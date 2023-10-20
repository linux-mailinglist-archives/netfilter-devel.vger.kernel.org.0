Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06BC7D0F27
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Oct 2023 13:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377314AbjJTLxA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Oct 2023 07:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377318AbjJTLw6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:52:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E204C38;
        Fri, 20 Oct 2023 04:42:29 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SBjKZ548zz6K6BX;
        Fri, 20 Oct 2023 19:39:14 +0800 (CST)
Received: from [10.123.123.126] (10.123.123.126) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 20 Oct 2023 12:41:43 +0100
Message-ID: <9fe690cb-a6ca-4c54-dd38-4d7a3cb02a4b@huawei.com>
Date:   Fri, 20 Oct 2023 14:41:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v13 10/12] selftests/landlock: Add 7 new test variants
 dedicated to network
Content-Language: ru
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
CC:     <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
        <linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
        <netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
        <artem.kuzin@huawei.com>
References: <20231016015030.1684504-1-konstantin.meskhidze@huawei.com>
 <20231016015030.1684504-11-konstantin.meskhidze@huawei.com>
 <20231016.phei8Is2weod@digikod.net>
From:   "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
In-Reply-To: <20231016.phei8Is2weod@digikod.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.123.126]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org



10/18/2023 3:32 PM, Mickaël Salaün пишет:
> You can update the subject with:
> "selftests/landlock: Add network tests"

Ok.
> 
> On Mon, Oct 16, 2023 at 09:50:28AM +0800, Konstantin Meskhidze wrote:
>> These test suites try to check edge cases for TCP sockets
>> bind() and connect() actions.
> 
> You can replace with that:
> Add 77 test suites to check edge cases related to bind() and connect()
> actions. They are defined with 6 fixtures and their variants:
> 
>> 
>> protocol:
>> * bind: Tests with non-landlocked/landlocked ipv4, ipv6 and unix sockets.
> 
> As you already did, you can write one paragraph per fixture, but
> starting by explaining the fixture and its related variants, and then
> listing the tests and explaining their specificities. For instance:
> 
> The "protocol" fixture is extended with 12 variants defined as a matrix
> of: sandboxed/not-sandboxed, IPv4/IPv6/unix network domain, and
> stream/datagram socket. 4 related tests suites are defined:
> * bind: Test bind combinations with increasingly more
>    restricting domains.
> * connect: Test connect combinations with increasingly more
>    restricting domains.
> ...

   Ok. Will be updated.
> 
> s/ipv/IPv/g

   Got it. Thanks.
> 
>> * connect: Tests with non-landlocked/landlocked ipv4, ipv6 and unix
>> sockets.
>> * bind_unspec: Tests with non-landlocked/landlocked restrictions
>> for bind action with AF_UNSPEC socket family.
>> * connect_unspec: Tests with non-landlocked/landlocked restrictions
>> for connect action with AF_UNSPEC socket family.
>> 
>> ipv4:
>> * from_unix_to_inet: Tests to make sure unix sockets' actions are not
>> restricted by Landlock rules applied to TCP ones.
>> 
>> tcp_layers:
>> * ruleset_overlap.
>> * ruleset_expand.
>> 
>> mini:
>> * network_access_rights: Tests with  legitimate access values.
>> * unknown_access_rights: Tests with invalid attributes, out of access range.
>> * inval:
>>     - unhandled allowed access.
>>     - zero access value.
>> * tcp_port_overflow: Tests with wrong port values more than U16_MAX.
>> 
>> ipv4_tcp:
>> * port_endianness: Tests with big/little endian port formats.
>> 
>> port_specific:
>> * bind_connect: Tests with specific port values.
>> 
>> layout1:
>> * with_net: Tests with network bind() socket action within
>> filesystem directory access test.
>> 
>> Test coverage for security/landlock is 94.5% of 932 lines according
>> to gcc/gcov-11.
>> 
>> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
>> Link: https://lore.kernel.org/r/20230920092641.832134-11-konstantin.meskhidze@huawei.com
>> Co-developed-by:: Mickaël Salaün <mic@digikod.net>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> ---
>> 
>> Changes since v12:
>> * Renames port_zero to port_specific fixture.
>> * Refactors port_specific test:
>>     - Adds set_port() and get_binded_port() helpers.
>>     - Adds checks for port 0, allowed by Landlock in this version.
>>     - Adds checks for port 1023.
>> * Refactors commit message.
>> 
> 
>> +static void set_port(struct service_fixture *const srv, in_port_t port)
>> +{
>> +	switch (srv->protocol.domain) {
>> +	case AF_UNSPEC:
>> +	case AF_INET:
>> +		srv->ipv4_addr.sin_port = port;
> 
> We should call htons() here, and make port a uint16_t.

   Done.
> 
>> +		return;
>> +
>> +	case AF_INET6:
>> +		srv->ipv6_addr.sin6_port = port;
>> +		return;
>> +
>> +	default:
>> +		return;
>> +	}
>> +}
>> +
>> +static in_port_t get_binded_port(int socket_fd,
> 
> The returned type should be uint16_t (i.e. host endianess).

   Done.
> 
>> +				 const struct protocol_variant *const prot)
>> +{
>> +	struct sockaddr_in ipv4_addr;
>> +	struct sockaddr_in6 ipv6_addr;
>> +	socklen_t ipv4_addr_len, ipv6_addr_len;
>> +
>> +	/* Gets binded port. */
>> +	switch (prot->domain) {
>> +	case AF_UNSPEC:
>> +	case AF_INET:
>> +		ipv4_addr_len = sizeof(ipv4_addr);
>> +		getsockname(socket_fd, &ipv4_addr, &ipv4_addr_len);
>> +		return ntohs(ipv4_addr.sin_port);
>> +
>> +	case AF_INET6:
>> +		ipv6_addr_len = sizeof(ipv6_addr);
>> +		getsockname(socket_fd, &ipv6_addr, &ipv6_addr_len);
>> +		return ntohs(ipv6_addr.sin6_port);
>> +
>> +	default:
>> +		return 0;
>> +	}
>> +}
> 
> These are good helpers!
> 
> 
>> +FIXTURE_TEARDOWN(ipv4)
>> +{
>> +}
>> +
>> +// Kernel FIXME: tcp_sandbox_with_tcp and tcp_sandbox_with_udp
> 
> No FIXME should remain.

   Ok. Deleted.
> 
>> +TEST_F(ipv4, from_unix_to_inet)
> 
>> +TEST_F(mini, network_access_rights)
>> +{
>> +	const struct landlock_ruleset_attr ruleset_attr = {
>> +		.handled_access_net = ACCESS_ALL,
>> +	};
>> +	struct landlock_net_port_attr net_service = {
> 
> Please rename to "net_port" everywhere.

   Done.
> 
>> +TEST_F(port_specific, bind_connect)
>> +{
>> +	int socket_fd, ret;
>> +
>> +	/* Adds the first rule layer with bind and connect actions. */
>> +	if (variant->sandbox == TCP_SANDBOX) {
>> +		const struct landlock_ruleset_attr ruleset_attr = {
>> +			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>> +					      LANDLOCK_ACCESS_NET_CONNECT_TCP
>> +		};
>> +		const struct landlock_net_port_attr tcp_bind_connect_zero = {
>> +			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
>> +					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
>> +			.port = htons(0),
> 
> We don't need any htons() calls anymore. It doesn't change the 0 value
> in this case but this is not correct.

  Yep. We call htons(port) in landlock_append_net_rule().
  Thanks.
> 
>> +		};
>> +
> 
> Useless new line.

   Ok. Thanks.
> 
>> +		int ruleset_fd;
>> +
>> +		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
>> +						     sizeof(ruleset_attr), 0);
>> +		ASSERT_LE(0, ruleset_fd);
>> +
>> +		/* Checks zero port value on bind and connect actions. */
>> +		EXPECT_EQ(0,
>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>> +					    &tcp_bind_connect_zero, 0));
>> +
>> +		enforce_ruleset(_metadata, ruleset_fd);
>> +		EXPECT_EQ(0, close(ruleset_fd));
>> +	}
>> +
>> +	socket_fd = socket_variant(&self->srv0);
>> +	ASSERT_LE(0, socket_fd);
>> +
>> +	/* Sets address port to 0 for both protocol families. */
>> +	set_port(&self->srv0, htons(0));
> 
> ditto
> 
>> +
>> +	/* Binds on port 0. */
>> +	ret = bind_variant(socket_fd, &self->srv0);
>> +	if (is_restricted(&variant->prot, variant->sandbox)) {
>> +		/* Binds to a random port within ip_local_port_range. */
>> +		EXPECT_EQ(0, ret);
>> +	} else {
>> +		/* Binds to a random port within ip_local_port_range. */
>> +		EXPECT_EQ(0, ret);
> 
> If the results are the same, no need to add an if block.

   Right. Updated.
> 
>> +	}
>> +
>> +	/* Connects on port 0. */
>> +	ret = connect_variant(socket_fd, &self->srv0);
>> +	if (is_restricted(&variant->prot, variant->sandbox)) {
>> +		EXPECT_EQ(-ECONNREFUSED, ret);
>> +	} else {
>> +		EXPECT_EQ(-ECONNREFUSED, ret);
>> +	}
> 
> ditto
> 
  Updated.
>> +
>> +	/* Binds on port 0. */
> 
> Please close sockets once they are used, and recreate one for another
> bind/connect to avoid wrong checks.

   Ok. But I can reuse socket_fd after closeing a socket. Correct?
> 
>> +	ret = bind_variant(socket_fd, &self->srv0);
>> +	if (is_restricted(&variant->prot, variant->sandbox)) {
>> +		/* Binds to a random port within ip_local_port_range. */
>> +		EXPECT_EQ(0, ret);
>> +	} else {
>> +		/* Binds to a random port within ip_local_port_range. */
>> +		EXPECT_EQ(0, ret);
>> +	}
> 
> Why this second bind() block? Furthermore, it is using the same
> socket_fd.

   I will refactor the code this way -  sockets will be recreated for 
each bind/connect, and I prefer to use self-connected sockets (use one 
socket descriptor) in these tests to make code simpler; testing logic 
remains the same way as if we have 2 sockets.

What do you think???

> 
>> +
>> +	/* Sets binded port for both protocol families. */
>> +	set_port(&self->srv0,
>> +		 htons(get_binded_port(socket_fd, &variant->prot)));
> 
> Ditto, these two endianess translations are useless.

   Updated. Thanks.
> 
> You can also add this to make sure the returned port is not 0:
> port = get_binded_port(socket_fd, &variant->prot);
> EXPECT_NE(0, port);
> set_port(&self->srv0, port);

   Ok. Thanks for the tip.
> 
>> +
>> +	/* Connects on the binded port. */
>> +	ret = connect_variant(socket_fd, &self->srv0);
>> +	if (is_restricted(&variant->prot, variant->sandbox)) {
>> +		/* Denied by Landlock. */
>> +		EXPECT_EQ(-EACCES, ret);
>> +	} else {
>> +		EXPECT_EQ(0, ret);
>> +	}
>> +
>> +	EXPECT_EQ(0, close(socket_fd));
>> +
> 
> 
> 
>> +	/* Adds the second rule layer with just bind action. */
> 
> There is not only bind actions here.

   Right.
> 
> This second part of the tests should be in a dedicated
> TEST_F(port_specific, bind_1023).

   Got it.
> 
>> +	if (variant->sandbox == TCP_SANDBOX) {
>> +		const struct landlock_ruleset_attr ruleset_attr = {
>> +			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>> +					      LANDLOCK_ACCESS_NET_CONNECT_TCP
>> +		};
>> +
>> +		const struct landlock_net_port_attr tcp_bind_zero = {
>> +			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
>> +			.port = htons(0),
>> +		};
>> +
> 
> Useless new lines.

   Got it.
> 
>> +		/* A rule with port value less than 1024. */
>> +		const struct landlock_net_port_attr tcp_bind_lower_range = {
>> +			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
>> +			.port = htons(1023),
>> +		};
>> +
> 
> Useless new line.

   Got it.
> 
>> +		int ruleset_fd;
>> +
>> +		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
>> +						     sizeof(ruleset_attr), 0);
>> +		ASSERT_LE(0, ruleset_fd);
>> +
>> +		ASSERT_EQ(0,
>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>> +					    &tcp_bind_lower_range, 0));
>> +		ASSERT_EQ(0,
>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>> +					    &tcp_bind_zero, 0));
>> +
>> +		enforce_ruleset(_metadata, ruleset_fd);
>> +		EXPECT_EQ(0, close(ruleset_fd));
>> +	}
>> +
>> +	socket_fd = socket_variant(&self->srv0);
> 
> We must have one socket FD dedicated to bind an another dedicated to
> connect, e.g. bind_fd and connect_fd, an close them after each use,
> otherwise tests might be inconsistent.

   Why can't we use self-connected sockets here? Why tests might be 
inconsistent? Tests will be working the same way as if we have 2 
sockets, plus the code is simpler.
> 
>> +	ASSERT_LE(0, socket_fd);
>> +
>> +	/* Sets address port to 1023 for both protocol families. */
>> +	set_port(&self->srv0, htons(1023));
>> +
>> +	/* Binds on port 1023. */
>> +	ret = bind_variant(socket_fd, &self->srv0);
>> +	if (is_restricted(&variant->prot, variant->sandbox)) {
> 
> No need to add this check if the result is the same for sandboxed and
> not sandboxed tests.

  Ok. Thanks.
> 
> Instead, use set_cap(_metadata, CAP_NET_BIND_SERVICE) and clear_cap()
> around this bind_variant() to make this test useful.
> 
> You will also need to patch common.h like this:
> @@ -112,10 +112,13 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
>          cap_t cap_p;
>          /* Only these three capabilities are useful for the tests. */
>          const cap_value_t caps[] = {
> +               /* clang-format off */
>                  CAP_DAC_OVERRIDE,
>                  CAP_MKNOD,
>                  CAP_SYS_ADMIN,
>                  CAP_SYS_CHROOT,
> +               CAP_NET_BIND_SERVICE,
> +               /* clang-format on */
>          };

  OK. Thanks.
> 
>> +		/* Denied by the system. */
>> +		EXPECT_EQ(-EACCES, ret);
>> +	} else {
>> +		/* Denied by the system. */
>> +		EXPECT_EQ(-EACCES, ret);
>> +	}
>> +
> 
> I don't see why the following part is useful. Why did you add it?
   Binding to ports < 1024 are forbidden by the system, not by Landlock.
   I added a rule with port 1023 to make sure it works as expected.

> Why tcp_bind_zero?
    Beacause it's a bind action with port zero rule.

> 
> The other parts are good though!
> 
>> +	/* Sets address port to 0 for both protocol families. */
>> +	set_port(&self->srv0, htons(0));
>> +
>> +	/* Binds on port 0. */
>> +	ret = bind_variant(socket_fd, &self->srv0);
>> +	if (is_restricted(&variant->prot, variant->sandbox)) {
>> +		/* Binds to a random port within ip_local_port_range. */
>> +		EXPECT_EQ(0, ret);
>> +	} else {
>> +		/* Binds to a random port within ip_local_port_range. */
>> +		EXPECT_EQ(0, ret);
>> +	}
>> +
>> +	/* Sets binded port for both protocol families. */
>> +	set_port(&self->srv0,
>> +		 htons(get_binded_port(socket_fd, &variant->prot)));
>> +
>> +	/* Connects on the binded port. */
>> +	ret = connect_variant(socket_fd, &self->srv0);
>> +	if (is_restricted(&variant->prot, variant->sandbox)) {
>> +		/* Denied by Landlock. */
>> +		EXPECT_EQ(-EACCES, ret);
>> +	} else {
>> +		EXPECT_EQ(0, ret);
>> +	}
>> +
>> +	EXPECT_EQ(0, close(socket_fd));
>> +}
>> +
>> +TEST_HARNESS_MAIN
>> --
>> 2.25.1
>> 
> .
