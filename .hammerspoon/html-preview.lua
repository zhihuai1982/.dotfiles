function chrome_active_tab_with_name(name)
    return function()
        hs.osascript.javascript([[
            // 以下为javascript代码
            var chrome = Application('Google Chrome');
            chrome.activate();
            var wins = chrome.windows;

            // 循环查找符合页面标题的标签页，并使之激活
            function main() {
                for (var i = 0; i < wins.length; i++) {
                    var win = wins.at(i);
                    var tabs = win.tabs;
                    for (var j = 0; j < tabs.length; j++) {
                    var tab = tabs.at(j);
                    tab.title(); j;
                    if (tab.title().indexOf(']] .. name .. [[') > -1) {
                            win.activeTabIndex = j + 1;
                            return;
                        }
                    }
                }
            }
            main();
            // javascript结束
        ]])
    end
end

--- Use
hs.hotkey.bind({"alt"}, "p", chrome_active_tab_with_name("reveal"))
