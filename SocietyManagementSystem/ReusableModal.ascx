<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReusableModal.ascx.cs" Inherits="SocietyManagementSystem.ReusableModal" %>
<div class="example-modal">
    <div id="reusableModal" runat="server" class="modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" runat="server" id="modalTitle"></h4>
                </div>
                <div class="modal-body">
                    <p runat="server" id="modalMessage"></p>
                </div>
            </div>
        </div>
    </div>
</div>
