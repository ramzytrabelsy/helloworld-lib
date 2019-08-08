# State Helper

## Usage

### Import

```javascript
import * as StateHelper from '../redux/state.helper';
```

### `StateHelper.createSimpleOperation`

```javascript
const MODULE = 'Post';

const defineInitialState = () => ({
  item: null,
});

const $selectItem = StateHelper.createSimpleOperation(MODULE, 'selectItem', (item) => {
  return (dispatch) => {
    dispatch($selectItem.action({ item  }));

    return fetch(`${API_ENDPOINT}/post/${item.id}`)
      .then(FetchHelper.ResponseHandler, FetchHelper.ErrorHandler)
      .then((result) => dispatch($selectItem.action({ item: result.item }));
  };
});

export function reducer(state = defineInitialState(), action) {
  switch (action.type) {
    case $selectItem.ACTION:
      return {
        ...state,
        item: action.item,
      };
    default:
      return state;
  }
}

// `dispatch($selectItem(item))` in components
```

### `StateHelper.createAsyncOperation`

```javascript
const MODULE = 'Post';

const defineInitialState = () => ({
  posts: null,
});

const $fetchPosts = StateHelper.createAsyncOperation(MODULE, 'fetchPosts', () => {
  return (dispatch) => {
    dispatch($fetchPosts.request());
    return fetch(`${API_ENDPOINT}/post`)
      .then(FetchHelper.ResponseHandler, FetchHelper.ErrorHandler)
      .then((result) => dispatch($fetchPosts.success({ posts: result.data })))
      .catch((error) => dispatch($fetchPosts.failure(error)));
  };
});

export function reducer(state = defineInitialState(), action) {
  switch (action.type) {
    case $fetchPosts.REQUEST:
      return {
        ...state,
        posts: null,
      };
    case $fetchPosts.SUCCESS:
      return {
        ...state,
        posts: action.posts,
      };
    case $fetchPosts.FAILURE:
      return {
        ...state,
        posts: null,
      };
    default:
      return state;
  }
}

// `dispatch($fetchPosts())` in components
```
