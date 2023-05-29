import { html } from 'gridjs';
import AngsaGridjsController from './angsa_gridjs_controller';

export default class <%= stimulus_controller_name %> extends AngsaGridjsController {
  columnsConfig(){
    // TODO: Return the appropriate columns for your model
    return [
<%= @columns.map { |column| '      \"#{column}\"' }.join(",\n") %>
    // {
    //   name: 'Actions', 
    //   formatter: (_, row) => html(`<a href='${this.apiUrl().replace('.json', '')}/${row.cells[3].data}'><i class='far fa-arrow-alt-circle-right'></></a>`)
    // },
    ]
    
  }


  apiUrl() {
    // TODO: Return the appropriate API URL for your model
    return '<%= angsa_api_url %>s.json';
  }

  dataProcessor() {
    // TODO: Return the appropriate data processing function for your model
    return (data) => data.data.map((item) => [
      <% @columns.each do |column| %>
      item.<%= column.downcase %>,
      <% end %>
    ]);
  }
}
