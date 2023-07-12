Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C61C7503E9
	for <lists+netfilter-devel@lfdr.de>; Wed, 12 Jul 2023 11:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGLJ5W (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 12 Jul 2023 05:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGLJ5V (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:57:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4768594;
        Wed, 12 Jul 2023 02:57:20 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R1Cjr4d5Bz6857p;
        Wed, 12 Jul 2023 17:53:36 +0800 (CST)
Received: from [10.123.123.126] (10.123.123.126) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 10:57:17 +0100
Message-ID: <0e549107-0435-717d-4b98-7f6578919c8b@huawei.com>
Date:   Wed, 12 Jul 2023 12:57:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v11.1] selftests/landlock: Add 11 new test suites
 dedicated to network
Content-Language: ru
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
CC:     <artem.kuzin@huawei.com>, <gnoack3000@gmail.com>,
        <willemdebruijn.kernel@gmail.com>, <yusongping@huawei.com>,
        <linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
        <netfilter-devel@vger.kernel.org>
References: <20230515161339.631577-11-konstantin.meskhidze@huawei.com>
 <20230706145543.1284007-1-mic@digikod.net>
 <3db64cf8-6a45-a361-aa57-9bfbaf866ef8@digikod.net>
From:   "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
In-Reply-To: <3db64cf8-6a45-a361-aa57-9bfbaf866ef8@digikod.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.123.126]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org



7/12/2023 10:02 AM, Mickaël Salaün пишет:
> 
> On 06/07/2023 16:55, Mickaël Salaün wrote:
>> From: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
>> 
>> This patch is a revamp of the v11 tests [1] with new tests (see the
>> "Changes since v11" description).  I (Mickaël) only added the following
>> todo list and the "Changes since v11" sections in this commit message.
>> I think this patch is good but it would appreciate reviews.
>> You can find the diff of my changes here but it is not really readable:
>> https://git.kernel.org/mic/c/78edf722fba5 (landlock-net-v11 branch)
>> [1] https://lore.kernel.org/all/20230515161339.631577-11-konstantin.meskhidze@huawei.com/
>> TODO:
>> - Rename all "net_service" to "net_port".
>> - Fix the two kernel bugs found with the new tests.
>> - Update this commit message with a small description of all tests.
> 
> [...]
> 
>> +FIXTURE_SETUP(ipv4)
>> +{
>> +	const struct protocol_variant prot = {
>> +		.domain = AF_INET,
>> +		.type = variant->type,
>> +	};
>> +
>> +	disable_caps(_metadata);
>> +
>> +	set_service(&self->srv0, prot, 0);
>> +	set_service(&self->srv1, prot, 1);
>> +
>> +	setup_loopback(_metadata);
>> +};
>> +
>> +FIXTURE_TEARDOWN(ipv4)
>> +{
>> +}
>> +
>> +// Kernel FIXME: tcp_sandbox_with_tcp and tcp_sandbox_with_udp
>> +TEST_F(ipv4, from_unix_to_inet)
>> +{
>> +	int unix_stream_fd, unix_dgram_fd;
>> +
>> +	if (variant->sandbox == TCP_SANDBOX) {
>> +		const struct landlock_ruleset_attr ruleset_attr = {
>> +			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>> +					      LANDLOCK_ACCESS_NET_CONNECT_TCP,
>> +		};
>> +		const struct landlock_net_service_attr tcp_bind_connect_p0 = {
>> +			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
>> +					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
>> +			.port = self->srv0.port,
>> +		};
>> +		int ruleset_fd;
>> +
>> +		/* Denies connect and bind to check errno value. */
>> +		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
>> +						     sizeof(ruleset_attr), 0);
>> +		ASSERT_LE(0, ruleset_fd);
>> +
>> +		/* Allows connect and bind for srv0.  */
>> +		ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
>> +					       LANDLOCK_RULE_NET_SERVICE,
>> +					       &tcp_bind_connect_p0, 0));
>> +
>> +		enforce_ruleset(_metadata, ruleset_fd);
>> +		EXPECT_EQ(0, close(ruleset_fd));
>> +	}
>> +
>> +	unix_stream_fd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
>> +	ASSERT_LE(0, unix_stream_fd);
>> +
>> +	unix_dgram_fd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
>> +	ASSERT_LE(0, unix_dgram_fd);
>> +
>> +	/* Checks unix stream bind and connect for srv0. */
>> +	EXPECT_EQ(-EINVAL, bind_variant(unix_stream_fd, &self->srv0));
>> +	EXPECT_EQ(-EINVAL, connect_variant(unix_stream_fd, &self->srv0));
>> +
>> +	/* Checks unix stream bind and connect for srv1. */
>> +	EXPECT_EQ(-EINVAL, bind_variant(unix_stream_fd, &self->srv1))
>> +	{
>> +		TH_LOG("Wrong bind error: %s", strerror(errno));
>> +	}
>> +	EXPECT_EQ(-EINVAL, connect_variant(unix_stream_fd, &self->srv1));
>> +
>> +	/* Checks unix datagram bind and connect for srv0. */
>> +	EXPECT_EQ(-EINVAL, bind_variant(unix_dgram_fd, &self->srv0));
>> +	EXPECT_EQ(-EINVAL, connect_variant(unix_dgram_fd, &self->srv0));
>> +
>> +	/* Checks unix datagram bind and connect for srv0. */
>> +	EXPECT_EQ(-EINVAL, bind_variant(unix_dgram_fd, &self->srv1));
>> +	EXPECT_EQ(-EINVAL, connect_variant(unix_dgram_fd, &self->srv1));
>> +}
> 
> We should also add a test to make sure errno is the same with and
> without sandboxing when using port 0 for connect and consistent with
> bind (using an available port). The test fixture and variants should be
> quite similar to the "ipv4" ones, but we can also add AF_INET6 variants,
> which will result in 8 "ip" variants:
> 
> TEST_F(ip, port_zero)
> {
> 	if (variant->sandbox == TCP_SANDBOX) {
> 		/* Denies any connect and bind. */
> 	}
> 	/* Checks errno for port 0. */
> }

  Ok. Got it.
> 
> [...]
> 
>> +FIXTURE(inet)
>> +{
>> +	struct service_fixture srv0, srv1;
>> +};
> 
> The "inet" variants are useless and should be removed. The "inet"
> fixture can then be renamed to "ipv4_tcp".
> 
   Right. Thanks.
> 
>> +
>> +FIXTURE_VARIANT(inet)
>> +{
>> +	const bool is_sandboxed;
>> +	const struct protocol_variant prot;
>> +};
>> +
>> +/* clang-format off */
>> +FIXTURE_VARIANT_ADD(inet, no_sandbox_with_ipv4) {
>> +	/* clang-format on */
>> +	.is_sandboxed = false,
>> +	.prot = {
>> +		.domain = AF_INET,
>> +		.type = SOCK_STREAM,
>> +	},
>> +};
>> +
>> +/* clang-format off */
>> +FIXTURE_VARIANT_ADD(inet, sandbox_with_ipv4) {
>> +	/* clang-format on */
>> +	.is_sandboxed = true,
>> +	.prot = {
>> +		.domain = AF_INET,
>> +		.type = SOCK_STREAM,
>> +	},
>> +};
>> +
>> +/* clang-format off */
>> +FIXTURE_VARIANT_ADD(inet, no_sandbox_with_ipv6) {
>> +	/* clang-format on */
>> +	.is_sandboxed = false,
>> +	.prot = {
>> +		.domain = AF_INET6,
>> +		.type = SOCK_STREAM,
>> +	},
>> +};
>> +
>> +/* clang-format off */
>> +FIXTURE_VARIANT_ADD(inet, sandbox_with_ipv6) {
>> +	/* clang-format on */
>> +	.is_sandboxed = true,
>> +	.prot = {
>> +		.domain = AF_INET6,
>> +		.type = SOCK_STREAM,
>> +	},
>> +};
>> +
>> +FIXTURE_SETUP(inet)
>> +{
>> +	const struct protocol_variant ipv4_tcp = {
>> +		.domain = AF_INET,
>> +		.type = SOCK_STREAM,
>> +	};
>> +
>> +	disable_caps(_metadata);
>> +
>> +	ASSERT_EQ(0, set_service(&self->srv0, ipv4_tcp, 0));
>> +	ASSERT_EQ(0, set_service(&self->srv1, ipv4_tcp, 1));
>> +
>> +	setup_loopback(_metadata);
>> +};
>> +
>> +FIXTURE_TEARDOWN(inet)
>> +{
>> +}
>> +
>> +TEST_F(inet, port_endianness)
>> +{
>> +	const struct landlock_ruleset_attr ruleset_attr = {
>> +		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>> +				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
>> +	};
>> +	const struct landlock_net_service_attr bind_host_endian_p0 = {
>> +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
>> +		/* Host port format. */
>> +		.port = self->srv0.port,
>> +	};
>> +	const struct landlock_net_service_attr connect_big_endian_p0 = {
>> +		.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
>> +		/* Big endian port format. */
>> +		.port = htons(self->srv0.port),
>> +	};
>> +	const struct landlock_net_service_attr bind_connect_host_endian_p1 = {
>> +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
>> +				  LANDLOCK_ACCESS_NET_CONNECT_TCP,
>> +		/* Host port format. */
>> +		.port = self->srv1.port,
>> +	};
>> +	const unsigned int one = 1;
>> +	const char little_endian = *(const char *)&one;
>> +	int ruleset_fd;
>> +
>> +	ruleset_fd =
>> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
>> +	ASSERT_LE(0, ruleset_fd);
>> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_SERVICE,
>> +				       &bind_host_endian_p0, 0));
>> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_SERVICE,
>> +				       &connect_big_endian_p0, 0));
>> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_SERVICE,
>> +				       &bind_connect_host_endian_p1, 0));
>> +	enforce_ruleset(_metadata, ruleset_fd);
>> +
>> +	/* No restriction for big endinan CPU. */
>> +	test_bind_and_connect(_metadata, &self->srv0, false, little_endian);
>> +
>> +	/* No restriction for any CPU. */
>> +	test_bind_and_connect(_metadata, &self->srv1, false, false);
>> +}
>> +
>> +TEST_HARNESS_MAIN
> .
