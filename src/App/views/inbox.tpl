{extends file="master.tpl"}

{block name=header}
    <link rel="stylesheet" href="{$publicRootPath}assets/DataTables/media/css/jquery.dataTables.min.css">
{/block}

{block name=title}SMS Inbox{/block}

{block name=panelBody}

    {if $flashMessages->hasMessages('success')}
        {$flashMessages->display('success')}
    {/if}

    <form id="inboxForm" method="POST" action="">
        <input type="hidden" name="inbox_delete" />
        <table id="inboxTable" class="table">
            <thead>
            <th width="2%"></th>
            <th width="18%">Date & Time</th>
            <th width="10%">From</th>
            <th width="70%">Text</th>
            </thead>
            <tbody>

            {foreach $simpleMessagingArray as $simpleMessaging}
                <tr>
                    <td><input name="filename[]" value="{$simpleMessaging->getFileName()}" type="checkbox"></td>
                    <td>{$simpleMessaging->getReceiveDateTime()->format('d/m/Y h:i:s A')}</td>
                    <td>{$simpleMessaging->getFromNumber()}</td>
                    <td>{$simpleMessaging->getText()}</td>
                </tr>
            {/foreach}

            </tbody>


        </table>
        <input class="btn btn-danger" type="submit" id="delete" value="Delete"  />
        <input class="btn btn-primary" id="select-all" type="button"  value="Select All"  />
    </form>
{/block}



{block name=footer}
    <script type="text/javascript" src="{$publicRootPath}assets/DataTables/media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $('#inboxTable').DataTable({
                "order": []
            });
        } );

        // Listen for click on select all checkbox
        $('#select-all').click(function(event) {

            // Iterate each checkbox
            $(':checkbox').each(function() {
                this.checked = true;
            });
        });

        // hook onsubmit
        $('#inboxForm').on('submit', function(e){
            e.preventDefault();
            var r = confirm("Are you sure to delete the messages?");
            if (r == true) {
                this.submit();
            }
        });

    </script>

{/block}