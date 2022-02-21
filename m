Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752DF4BDC4E
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Feb 2022 18:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378373AbiBUOvj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Feb 2022 09:51:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbiBUOvj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:51:39 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16C175F80
        for <netfilter-devel@vger.kernel.org>; Mon, 21 Feb 2022 06:51:16 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 1112860225;
        Mon, 21 Feb 2022 15:50:19 +0100 (CET)
Date:   Mon, 21 Feb 2022 15:51:13 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: Re: [PATCH v3] netfilter: nf_tables: fix memory leak during stateful
 obj update
Message-ID: <YhOm4e8fdfZU9Qd5@salvia>
References: <20220221123149.11519-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220221123149.11519-1-fw@strlen.de>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Feb 21, 2022 at 01:31:49PM +0100, Florian Westphal wrote:
> stateful objects can be updated from the control plane.
> The transaction logic allocates a temporary object for this purpose.
> 
> The ->init function was called for this object, so plain kfree() leaks
> resources. We must call ->destroy function of the object.
> 
> nft_obj_destroy does this, but it also decrements the module refcount,
> but the update path doesn't increment it.
> 
> To avoid special-casing the update object release, do module_get for
> the update case too and release it via nft_obj_destroy().

Also applied, thanks
