Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816635ABF38
	for <lists+netfilter-devel@lfdr.de>; Sat,  3 Sep 2022 16:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiICOGd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 3 Sep 2022 10:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiICOGa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 3 Sep 2022 10:06:30 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9382850196
        for <netfilter-devel@vger.kernel.org>; Sat,  3 Sep 2022 07:06:25 -0700 (PDT)
Date:   Sat, 3 Sep 2022 16:06:22 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v2] json: add set statement list support
Message-ID: <YxNfXkBPgtKUx+ws@salvia>
References: <20220901103143.87974-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220901103143.87974-1-ffmancera@riseup.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Sep 01, 2022 at 12:31:43PM +0200, Fernando Fernandez Mancera wrote:
> When listing a set with statements with JSON support, the statements were
> ignored.
> 
> Output example:
> 
> {
>   "set": {
>     "op": "add",
>     "elem": {
>       "payload": {
>         "protocol": "ip",
>         "field": "saddr"
>       }
>     },
>     "stmt": [
>       {
>         "limit": {
>           "rate": 10,
>           "burst": 5,
>           "per": "second"
>         }
>       },
>       {
>         "counter": {
>           "packets": 0,
>           "bytes": 0
>         }
>       }
>     ],
>     "set": "@my_ssh_meter"
>   }
> }

ip/sets.t: WARNING: line 53: '{"nftables": [{"add": {"rule": {"table": "test-ip4", "chain": "input", "family": "ip", "expr": [{"set": {"set": "@set5", "elem": {"concat": [{"payload": {"field": "saddr", "protocol": "ip"}}, {"payload": {"field": "daddr", "protocol": "ip"}}]}, "op": "add"}}]}}}]}': '[{"set": {"elem": {"concat": [{"payload": {"field": "saddr", "protocol": "ip"}}, {"payload": {"field": "daddr", "protocol": "ip"}}]}, "op": "add", "set": "@set5"}}]' mismatches '[{"set": {"elem": {"concat": [{"payload": {"field": "saddr", "protocol": "ip"}}, {"payload": {"field": "daddr", "protocol": "ip"}}]}, "op": "add", "set": "@set5", "stmt": []}}]'

tests/py in nftables reports this warning.

I think it should be possible not to print "stmt" if it is empty.

Please follow up with an incremental patch to address this.

Thanks.
