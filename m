Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABDC6B2C38
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Mar 2023 18:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCIRn5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 Mar 2023 12:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjCIRnu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:43:50 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBFD75DCB0
        for <netfilter-devel@vger.kernel.org>; Thu,  9 Mar 2023 09:43:26 -0800 (PST)
Date:   Thu, 9 Mar 2023 18:43:23 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] xt: Fix fallback printing for extensions matching
 keywords
Message-ID: <ZAoauxzjCq7jYevG@salvia>
References: <20230309134350.9803-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230309134350.9803-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Mar 09, 2023 at 02:43:50PM +0100, Phil Sutter wrote:
> Yet another Bison workaround: Instead of the fancy error message, an
> incomprehensible syntax error is emitted:
> 
> | # iptables-nft -A FORWARD -p tcp -m osf --genre linux
> | # nft list ruleset | nft -f -
> | # Warning: table ip filter is managed by iptables-nft, do not touch!
> | /dev/stdin:4:29-31: Error: syntax error, unexpected osf, expecting string
> | 		meta l4proto tcp xt match osf counter packets 0 bytes 0
> | 		                          ^^^
> 
> Avoid this by quoting the extension name when printing:
> 
> | # nft list ruleset | sudo ./src/nft -f -
> | # Warning: table ip filter is managed by iptables-nft, do not touch!
> | /dev/stdin:4:20-33: Error: unsupported xtables compat expression, use iptables-nft with this ruleset
> | 		meta l4proto tcp xt match "osf" counter packets 0 bytes 0
> | 		                 ^^^^^^^^^^^^^^


LGTM.
