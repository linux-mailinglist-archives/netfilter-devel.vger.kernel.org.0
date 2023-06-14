Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1CC717C38
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 May 2023 11:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjEaJlm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 May 2023 05:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbjEaJlX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 May 2023 05:41:23 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127A1E42
        for <netfilter-devel@vger.kernel.org>; Wed, 31 May 2023 02:41:09 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id DE76B587493E8; Wed, 31 May 2023 11:41:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id DC1FB60C0132C;
        Wed, 31 May 2023 11:41:07 +0200 (CEST)
Date:   Wed, 31 May 2023 11:41:07 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     ValdikSS <iam@valdikss.org.ru>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: xtables-addons: ipp2p does not block TCP traffic with nonlinear
 skb
In-Reply-To: <2b05bb89-08bf-b3b1-c2d7-9b391953f303@valdikss.org.ru>
Message-ID: <7rr4q976-5qn6-382r-0pp-66rq492r9376@vanv.qr>
References: <2b05bb89-08bf-b3b1-c2d7-9b391953f303@valdikss.org.ru>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Wednesday 2023-05-31 08:42, ValdikSS wrote:
> However, it's not getting processed due to nonlinear skb:
>
>> static bool
>> ipp2p_mt(const struct sk_buff *skb, struct xt_action_param *par)
>>  /* make sure that skb is linear */
>>  if (skb_is_nonlinear(skb)) {
>>   if (info->debug)
>>   	printk("IPP2P.match: nonlinear skb found\n");
>>  	return 0;
>>  }

It should be possible to just take the code from xt_ECHO and call

if (skb_linearize(skb) < 0)
	return false;

However, none of the xtables matches in the Linux kernel do this linearization,
at least not that I can see directly. Or xt_string's call to skb_find_text is
magic..
