<template>
  <div class="my-app">
    <h1>Online now</h1>
		<table>
			<tr v-for="who in whos">
				<td>{{ who.name }}</td>
				<td>{{ who.hostname }}</td>
				<td>{{ who.tty }}</td>
			</tr>
		</table>
  </div>
</template>

<script>

export default {
  data() {
    return {
      who: {}
    }
  },
	computed: {
		whos() {
			return this.$parent.whos
		}
	},
  render(createElement) {
    return createElement(MyApp, {})
  }
}
</script>

<style lang="sass">
.my-app {
  margin-left: auto;
  margin-right: auto;
  width: 800px;
  h1 {
    text-align: center;
  }
}
</style>
