'INSTANT VB NOTE: This code snippet uses implicit typing. You will need to set 'Option Infer On' in the VB file or set 'Option Infer' at the project level:

<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
	<script type="text/javascript">
		function OnBatchEditEndEditing(s, e) {
			var originalValue = s.batchEditApi.GetCellValue(e.visibleIndex, "C2");
			var newValue = e.rowValues[(s.GetColumnByField("C2").index)].value;

			var dif = newValue - originalValue;
			labelSum.SetValue((parseFloat(labelSum.GetValue()) + dif).toFixed(1));

		}
	</script>
</head>
<body>
	<form id="frmMain" runat="server">
	<dx:ASPxGridView ID="Grid" runat="server" KeyFieldName="ID" OnBatchUpdate="Grid_BatchUpdate"
		OnRowInserting="Grid_RowInserting" OnRowUpdating="Grid_RowUpdating" OnRowDeleting="Grid_RowDeleting"
		ClientInstanceName="gridView" Theme="Office2010Silver">
		<Columns>
			<dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowDeleteButton="true" />
			<dx:GridViewDataColumn FieldName="C1" />
			<dx:GridViewDataSpinEditColumn FieldName="C2">
				<FooterTemplate>
					Sum =
					<dx:ASPxLabel ID="ASPxLabel1" runat="server" ClientInstanceName="labelSum" Text='<%#GetTotalSummaryValue()%>'>
					</dx:ASPxLabel>
				</FooterTemplate>
			</dx:GridViewDataSpinEditColumn>
			<dx:GridViewDataTextColumn FieldName="C3" />
			<dx:GridViewDataCheckColumn FieldName="C4" />
			<dx:GridViewDataDateColumn FieldName="C5" />
		</Columns>
		<SettingsEditing Mode="Batch" />
		<Settings ShowFooter="true" />
		<TotalSummary>
			<dx:ASPxSummaryItem SummaryType="Sum" FieldName="C2" Tag="C2_Sum" />
		</TotalSummary>
		<Templates>
			<StatusBar>
				<div style="text-align: right">
					<dx:ASPxHyperLink ID="hlSave" runat="server" Text="Save changes">
						<ClientSideEvents Click="function(s, e){ gridView.UpdateEdit(); }" />
					</dx:ASPxHyperLink>
					&nbsp;
					<dx:ASPxHyperLink ID="hlCancel" runat="server" Text="Cancel changes">
						<ClientSideEvents Click="function(s, e){ gridView.CancelEdit(); gridView.Refresh(); }" />
					</dx:ASPxHyperLink>
				</div>
			</StatusBar>
		</Templates>
		<ClientSideEvents BatchEditEndEditing="OnBatchEditEndEditing" />
	</dx:ASPxGridView>
	</form>
</body>
</html>