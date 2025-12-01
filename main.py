from fastapi import FastAPI, HTTPException, Body
from fastapi.responses import HTMLResponse
from pydantic import BaseModel

app = FastAPI()

dynamic_pages = {}


class PageContent(BaseModel):
    content: str

@app.put("/hook")
def notify(_json: PageContent):
    
    print(_json.content)
    return {"message": "received"}

@app.post("/{page_name}")
def create_page(page_name: str,
                _json: PageContent | None = Body(None),
                ):
    if page_name in dynamic_pages:
        raise HTTPException(status_code=400, detail="Page already exists")
    dynamic_pages[page_name] = _json.content
    return {"message": f"Page '{page_name}' created"}


@app.get("/{page_name}", response_class=HTMLResponse)
def get_page(page_name: str):
    if page_name not in dynamic_pages:
        raise HTTPException(status_code=404, detail="Page not found")
    return dynamic_pages[page_name]


@app.delete("/{page_name}")
def delete_page(page_name: str):
    if page_name not in dynamic_pages:
        raise HTTPException(status_code=404, detail="Page not found")
    del dynamic_pages[page_name]
    return {"message": f"Page '{page_name}' deleted"}
