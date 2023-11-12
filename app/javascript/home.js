function changeUrl(params) {
  let anchor = document.querySelector("#create-task-link");
  let value = params.options[params.selectedIndex].value;

  let url = new URL(anchor.href);
  url.searchParams.set("group_name", value);
  anchor.href = url.toString();
}
