$(function () {
    $(".notify").hide();
    if (GetParentResourceName() === 'world-panel') {
        const showWorlds = (bool) => {
            if (bool) {
                $('.container').css({'opacity': '1'})
            } else {
                $('.container').css({'opacity': '0'})
            }
        };

        document.onkeyup = function (data) {
            if (data.which == 27) {
                $.post('https://world-panel/closed', JSON.stringify({}));
                showWorlds(false)
                return
            }
        };
        window.addEventListener('message', function(event){
            let v = event.data;
            if (v.type == 'opened') {
                showWorlds(true)
                document.getElementById('worldContainer').innerHTML = ''
                updateWorlds(v.worlds)
                $(".btn-world").click(function () { 
                    if (v.inVeh) {
                        $(".notify").fadeIn();
                        setTimeout(function () {
                            $(".notify").fadeOut();
                        }, 2000);
                        return false
                    } else {
                        $.post('https://world-panel/enter', JSON.stringify({world: $(this).attr('data-id')}))
                        showWorlds(false)
                    }
                });
                $(".back").click(function () {
                    $.post('https://world-panel/comeback', JSON.stringify({}))
                    showWorlds(false)

                });
            } else {
                showWorlds(false)
            }
        })
    } else {
        console.log('^5[WorldPanel]^0 Please, rename script to world-panel.\n\nScript -->')
    }
});
const updateWorlds = (worldTable) => {
    for (let i = 0; i < worldTable.length; i++) {
        document.getElementById('worldContainer').innerHTML += 
        `
        <div class="world">
            <div class="world-name">${worldTable[i].name}</div>
            <div class="world-desc">${worldTable[i].desc}</div>
            <div class="btn-world" data-id=${worldTable[i].dimension}>Entrar</div>
        </div>
        `
    } 
}