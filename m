Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3075A80D3
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Aug 2022 17:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiHaPC5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 Aug 2022 11:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiHaPCz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:02:55 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D68ED399F
        for <netfilter-devel@vger.kernel.org>; Wed, 31 Aug 2022 08:02:54 -0700 (PDT)
Date:   Wed, 31 Aug 2022 17:02:50 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] json: add set statement list support
Message-ID: <Yw94Gux4j02HzCh2@salvia>
References: <20220831123731.26249-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220831123731.26249-1-ffmancera@riseup.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Fernando,

On Wed, Aug 31, 2022 at 02:37:31PM +0200, Fernando Fernandez Mancera wrote:
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

LGTM, thanks.

Would you also extend tests/shell? There is a
tests/shell/testcases/json/ folder where you can add one.

One example test can be found here: tests/shell/testcases/json/netdev

If you also create this folder:

  tests/shell/testcases/json/dump/mytest.dump

where 'mytest' is the name of you script under tests/shell/testcases/json/

Then, it also checks for the expected output via 'nft list ruleset'.
