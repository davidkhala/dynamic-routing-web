
from fastapi import FastAPI, HTTPException
from fastapi.responses import HTMLResponse
app = FastAPI()

# 用字典来存储动态页面 {url_path: html_content}
dynamic_pages = {}

@app.post("/{page_name}")
def create_page(page_name: str, content: str):
    if page_name in dynamic_pages:
        raise HTTPException(status_code=400, detail="Page already exists")
    dynamic_pages[page_name] = content
    return {"message": f"Page '{page_name}' created", "url": f"/{page_name}"}

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