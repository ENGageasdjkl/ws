export default {
  async fetch(req: Request) {
    const url = new URL(req.url);

    // 如果访问的是根路径 "/", 返回 index.html
    if (url.pathname === "/") {
      return new Response(
        await fetch(new URL("dist/index.html", import.meta.url))
      );
    }

    // 如果请求的是静态文件，返回相应的文件
    if (url.pathname.startsWith("/assets/")) {
      return new Response(
        await fetch(new URL(`dist${url.pathname}`, import.meta.url))
      );
    }

    // 默认返回 404
    return new Response("Not Found", { status: 404 });
  }
};
