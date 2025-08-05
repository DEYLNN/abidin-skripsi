// Supabase JavaScript Client - Offline Version
// Fallback jika CDN diblokir

// Simple Supabase client implementation
class SupabaseClient {
  constructor(url, key) {
    this.supabaseUrl = url;
    this.supabaseKey = key;
    this.headers = {
      apikey: key,
      Authorization: `Bearer ${key}`,
      "Content-Type": "application/json",
    };
  }

  from(table) {
    return new SupabaseQuery(this.supabaseUrl, this.supabaseKey, table);
  }
}

class SupabaseQuery {
  constructor(url, key, table) {
    this.url = url;
    this.key = key;
    this.table = table;
    this.headers = {
      apikey: key,
      Authorization: `Bearer ${key}`,
      "Content-Type": "application/json",
    };
    this.params = new URLSearchParams();
  }

  select(columns = "*") {
    this.params.set("select", columns);
    return this;
  }

  eq(column, value) {
    this.params.set(`${column}`, `eq.${value}`);
    return this;
  }

  or(condition) {
    this.params.set("or", condition);
    return this;
  }

  order(column, options = {}) {
    const direction = options.ascending ? "asc" : "desc";
    this.params.set("order", `${column}.${direction}`);
    return this;
  }

  limit(count) {
    this.params.set("limit", count);
    return this;
  }

  async execute() {
    const url = `${this.url}/rest/v1/${this.table}?${this.params.toString()}`;

    try {
      const response = await fetch(url, {
        method: "GET",
        headers: this.headers,
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      const data = await response.json();
      return { data, error: null };
    } catch (error) {
      return { data: null, error };
    }
  }

  async insert(data) {
    const url = `${this.url}/rest/v1/${this.table}`;

    try {
      const response = await fetch(url, {
        method: "POST",
        headers: this.headers,
        body: JSON.stringify(data),
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      const result = await response.json();
      return { data: result, error: null };
    } catch (error) {
      return { data: null, error };
    }
  }

  async update(data) {
    const url = `${this.url}/rest/v1/${this.table}`;

    try {
      const response = await fetch(url, {
        method: "PATCH",
        headers: this.headers,
        body: JSON.stringify(data),
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      const result = await response.json();
      return { data: result, error: null };
    } catch (error) {
      return { data: null, error };
    }
  }

  async delete() {
    const url = `${this.url}/rest/v1/${this.table}`;

    try {
      const response = await fetch(url, {
        method: "DELETE",
        headers: this.headers,
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      return { data: null, error: null };
    } catch (error) {
      return { data: null, error };
    }
  }
}

// Global Supabase object
window.supabase = {
  createClient: (url, key) => {
    return new SupabaseClient(url, key);
  },
};

console.log("Supabase offline client loaded");
