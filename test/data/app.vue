<style lang="stylus" src="./app.styl"></style>

<template lang="jade">
div#app
  h1 {{fib(100)}}
</template>

<script>
function fib(i) {
  return i < 2 ? 1 : fib(i-1) + fib(i-2);
}

export default {
  methods: {
    fib: fib,
  },
};
</script>
