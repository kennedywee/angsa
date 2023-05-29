import { Controller } from '@hotwired/stimulus';
import { Grid } from 'gridjs';

export default class AngsaGridjsController extends Controller {
  connect() {
    this.initializeGrid();
  }

  initializeGrid() {
    const grid = new Grid({
      language: this.languageConfig(),
      columns: this.columnsConfig(),
      server: {
        url: this.apiUrl(),
        then: this.dataProcessor(),
        total: this.totalRecords(),
      },
      pagination: this.paginationConfig(),
      search: this.searchConfig(),
      sort: this.sortConfig(),
    });

    grid.render(document.getElementById('gridjs'))
  }

  languageConfig() {
    return {
      search: {
        placeholder: '🔍 Search...',
      },
      // pagination: {
      //   previous: '⬅️',
      //   next: '➡️',
      //   showing: '😃 Displaying',
      //   results: () => 'Records',
      // },
    };
  }

  columnsConfig() {
    throw new Error('columnsConfig() must be implemented in the child class.');
  }

  apiUrl() {
    throw new Error('apiUrl() must be implemented in the child class.');
  }

  dataProcessor() {
    throw new Error('dataProcessor() must be implemented in the child class.');
  }

  totalRecords() {
    return (data) => data.total;
  }

  paginationConfig() {
    return {
      enabled: true,
      limit: 10,
      server: {
        url: (prev, page, limit) => {
          return `${prev}${prev.includes('?') ? '&' : '?'}limit=${limit}&offset=${page * limit}`;
        },
      },
    };
  }

  sortConfig() {
    return {
      enabled: true,
      multiColumn: false,
      server: {
        url: (prev, columns) => {
          if (!columns.length) return prev;

          const col = columns[0];
          const dir = col.direction === 1 ? 'asc' : 'desc';
          const colName = this.columnsConfig()[col.index].toLowerCase();

          // Get the base URL without any query parameters
          const baseUrl = prev.split('?')[0];

          // Remove existing order and dir parameters
          const searchParams = new URLSearchParams(prev.split('?')[1] || '');
          searchParams.delete('order');
          searchParams.delete('dir');

          // Add new order and dir parameters
          searchParams.set('order', colName);
          searchParams.set('dir', dir);

          // Return the modified URL
          return `${baseUrl}?${searchParams.toString()}`;
        },
      },
    };
  }

  searchConfig() {
    return {
      server: {
        url: (prev, keyword) => {
          // Get the base URL without any query parameters
          const baseUrl = prev.split('?')[0];
  
          // Remove existing search parameter
          const searchParams = new URLSearchParams(prev.split('?')[1] || '');
          searchParams.delete('search');
  
          // Add new search parameter
          searchParams.set('search', keyword);
  
          // Return the modified URL
          return `${baseUrl}?${searchParams.toString()}`;
        },
      },
    };
  }  
}
