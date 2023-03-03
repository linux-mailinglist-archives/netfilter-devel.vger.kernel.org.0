Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9976F6A93D5
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Mar 2023 10:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjCCJYe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Mar 2023 04:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjCCJYS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:24:18 -0500
Received: from mail.balasys.hu (mail.balasys.hu [185.199.30.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF77A28215
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Mar 2023 01:23:51 -0800 (PST)
Received: from [10.90.100.85] (unknown [10.90.100.85])
        by mail.balasys.hu (Postfix) with ESMTPSA id 008CC2B49C3;
        Fri,  3 Mar 2023 10:23:36 +0100 (CET)
Message-ID: <374ce7bf-e953-ab61-15ac-d99efce9152d@balasys.hu>
Date:   Fri, 3 Mar 2023 10:23:36 +0100
MIME-Version: 1.0
Content-Language: en-US
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
References: <401bd6ed-314a-a196-1cdc-e13c720cc8f2@balasys.hu>
 <20230302142946.GB309@breakpoint.cc>
 <f8d03b81-8980-b54e-a2a3-57f8e54044be@balasys.hu>
 <20230303000926.GC9239@breakpoint.cc>
From:   =?UTF-8?Q?Major_D=c3=a1vid?= <major.david@balasys.hu>
Subject: Re: CPU soft lockup in a spin lock using tproxy and nfqueue
In-Reply-To: <20230303000926.GC9239@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On 3/3/23 01:09, Florian Westphal wrote:
> 
> Which one?  As far as I can see TCP stack would end up adding a
> duplicate quadruple to the hash if we only drop the reference and
> keep the listen sk around.

I just thought that tcp_timewait_state_process is called by TCP stack to
handle TW state, which actually call inet_twsk_deschedule_put parallel to tproxy and
that would be the root cause of the deadlock.

So I guess now, basically we would leak away the tw socket if we do not call put in tproxy?


