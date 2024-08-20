Return-Path: <netfilter-devel+bounces-3402-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975D5958832
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Aug 2024 15:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BAE284922
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Aug 2024 13:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECB31B7E9;
	Tue, 20 Aug 2024 13:46:32 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914874C91;
	Tue, 20 Aug 2024 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161592; cv=none; b=ZOTHNatcvJwaZPkW/uOJMgi52Ej2mNfAbKfeH1N55rQQXQzhPTv05nlq6jBjpHFwfAM/Z062wKkpengKMA4oGUd87I1U16H5TjUWt2Zy/qmLpaub4UxAUS8yOPKNkXO+Uk6ecty2dwTHDmFdNYwwEgQ+A+N14VR/InBqaIDKBlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161592; c=relaxed/simple;
	bh=YH6HpoQO2pQo8AiI6P28NZ2yfEHkhOzM/CXWi32w12U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ET2QZBnf/1NpzFuYG5ZjAbmBizNzLkJ3YbGFWC0X7oS82OOor6SgwIzhf6TjP5KPAbijItYYpdJubQxcbBa3jxBc5PWkupwxaEFwjPvPwu26wtPC+NZCqMG2bfuyeTwLOOlrkFDPdk8XwhAkGNRQ1ld+VMB77HYBwkPrOBjWMDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wp9gF54hTzhXx0;
	Tue, 20 Aug 2024 21:44:25 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id D5BE7140135;
	Tue, 20 Aug 2024 21:46:25 +0800 (CST)
Received: from [10.123.123.159] (10.123.123.159) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 21:46:21 +0800
Message-ID: <58b328fc-aa98-c4f1-eb11-2d59e50ec407@huawei-partners.com>
Date: Tue, 20 Aug 2024 16:46:17 +0300
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 6/9] selftests/landlock: Test listening without
 explicit bind restriction
Content-Language: ru
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
CC: <mic@digikod.net>, <willemdebruijn.kernel@gmail.com>,
	<gnoack3000@gmail.com>, <linux-security-module@vger.kernel.org>,
	<netdev@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<yusongping@huawei.com>, <artem.kuzin@huawei.com>,
	<konstantin.meskhidze@huawei.com>
References: <20240814030151.2380280-1-ivanov.mikhail1@huawei-partners.com>
 <20240814030151.2380280-7-ivanov.mikhail1@huawei-partners.com>
 <ZsST6Nk3Bf8F5lmJ@google.com>
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <ZsST6Nk3Bf8F5lmJ@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 dggpemm500020.china.huawei.com (7.185.36.49)

8/20/2024 4:02 PM, Günther Noack wrote:
> On Wed, Aug 14, 2024 at 11:01:48AM +0800, Mikhail Ivanov wrote:
>> Test scenarios where listen(2) call without explicit bind(2) is allowed
>> and forbidden.
>>
>> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
>> ---
>>   tools/testing/selftests/landlock/net_test.c | 83 +++++++++++++++++++++
>>   1 file changed, 83 insertions(+)
>>
>> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
>> index 551891b18b7a..92c042349596 100644
>> --- a/tools/testing/selftests/landlock/net_test.c
>> +++ b/tools/testing/selftests/landlock/net_test.c
>> @@ -1851,6 +1851,89 @@ TEST_F(port_specific, bind_connect_zero)
>>   	EXPECT_EQ(0, close(bind_fd));
>>   }
>>   
>> +TEST_F(port_specific, listen_without_bind_allowed)
>> +{
>> +	if (variant->sandbox == TCP_SANDBOX) {
>> +		const struct landlock_ruleset_attr ruleset_attr = {
>> +			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>> +					      LANDLOCK_ACCESS_NET_LISTEN_TCP
>> +		};
>> +		const struct landlock_net_port_attr tcp_listen_zero = {
>> +			.allowed_access = LANDLOCK_ACCESS_NET_LISTEN_TCP,
>> +			.port = 0,
>> +		};
>> +		int ruleset_fd;
>> +
>> +		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
>> +						     sizeof(ruleset_attr), 0);
>> +		ASSERT_LE(0, ruleset_fd);
>> +
>> +		/*
>> +		 * Allow listening without explicit bind
>> +		 * (cf. landlock_net_port_attr).
>> +		 */
>> +		EXPECT_EQ(0,
>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>> +					    &tcp_listen_zero, 0));
>> +
>> +		enforce_ruleset(_metadata, ruleset_fd);
>> +		EXPECT_EQ(0, close(ruleset_fd));
>> +	}
>> +	int listen_fd, connect_fd;
>> +	__u64 port;
>> +
>> +	listen_fd = socket_variant(&self->srv0);
>> +	ASSERT_LE(0, listen_fd);
>> +
>> +	connect_fd = socket_variant(&self->srv0);
>> +	ASSERT_LE(0, connect_fd);
>> +	/*
>> +	 * Allow listen(2) to select a random port for the socket,
>> +	 * since bind(2) wasn't called.
>> +	 */
>> +	EXPECT_EQ(0, listen_variant(listen_fd, backlog));
>> +
>> +	/* Connects on the binded port. */
>> +	port = get_binded_port(listen_fd, &variant->prot);
> 
> Please rename "binded" to "bound" when you come across it.

Can I do such refactoring in the 3/9 patch?

> 
> 
>> +	EXPECT_NE(0, port);
>> +	set_port(&self->srv0, port);
>> +	EXPECT_EQ(0, connect_variant(connect_fd, &self->srv0));
>> +
>> +	EXPECT_EQ(0, close(connect_fd));
>> +	EXPECT_EQ(0, close(listen_fd));
>> +}
>> +
>> +TEST_F(port_specific, listen_without_bind_denied)
>> +{
>> +	if (variant->sandbox == TCP_SANDBOX) {
>> +		const struct landlock_ruleset_attr ruleset_attr = {
>> +			.handled_access_net = LANDLOCK_ACCESS_NET_LISTEN_TCP
>> +		};
>> +		int ruleset_fd;
>> +
>> +		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
>> +						     sizeof(ruleset_attr), 0);
>> +		ASSERT_LE(0, ruleset_fd);
>> +
>> +		/* Deny listening. */
>> +		enforce_ruleset(_metadata, ruleset_fd);
>> +		EXPECT_EQ(0, close(ruleset_fd));
>> +	}
>> +	int listen_fd, ret;
>> +
>> +	listen_fd = socket_variant(&self->srv0);
>> +	ASSERT_LE(0, listen_fd);
>> +
>> +	/* Checks that listening without explicit binding is prohibited. */
>> +	ret = listen_variant(listen_fd, backlog);
>> +	if (is_restricted(&variant->prot, variant->sandbox)) {
>> +		/* Denied by Landlock. */
>> +		EXPECT_EQ(-EACCES, ret);
>> +	} else {
>> +		EXPECT_EQ(0, ret);
>> +	}
>> +}
>> +
>>   TEST_F(port_specific, port_1023)
>>   {
>>   	int bind_fd, connect_fd, ret;
>> -- 
>> 2.34.1
>>

