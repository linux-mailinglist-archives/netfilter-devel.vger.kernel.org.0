Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286BA71F2C6
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Jun 2023 21:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjFATSI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Jun 2023 15:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjFATSI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:18:08 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F09513E;
        Thu,  1 Jun 2023 12:18:07 -0700 (PDT)
Date:   Thu, 1 Jun 2023 21:18:05 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        Abhijeet Rastogi <abhijeet.1989@gmail.com>
Subject: Re: [PATCH net-next] ipvs: dynamically limit the connection hash
 table
Message-ID: <ZHju7cARozHokVFU@calendula>
References: <20230517123731.56733-1-ja@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517123731.56733-1-ja@ssi.bg>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 17, 2023 at 03:37:31PM +0300, Julian Anastasov wrote:
> As we allow the hash table to be configured to rows above 2^20,
> we should limit it depending on the available memory to some
> sane values. Switch to kvmalloc allocation to better select
> the needed allocation type.
> 
> Signed-off-by: Julian Anastasov <ja@ssi.bg>
> ---
>  net/netfilter/ipvs/ip_vs_conn.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
>  NOTE: This patch needs to be applied on top of V3 (or above) of patch
>  "ipvs: increase ip_vs_conn_tab_bits range for 64BIT" from Abhijeet

Done, thanks for this note.

Applied to nf-next, thanks.
