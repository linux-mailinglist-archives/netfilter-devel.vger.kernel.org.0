Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9FD7E0ABC
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Nov 2023 22:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjKCVhx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Nov 2023 17:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjKCVhw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Nov 2023 17:37:52 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CD9D55
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Nov 2023 14:37:50 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qz1rQ-00046F-7F; Fri, 03 Nov 2023 22:37:48 +0100
Date:   Fri, 3 Nov 2023 22:37:48 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft v3 1/2] json: drop handling missing json() hook in
 expr_print_json()
Message-ID: <ZUVoLKrYbqHu6Hby@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Thomas Haller <thaller@redhat.com>,
        NetFilter <netfilter-devel@vger.kernel.org>
References: <20231103162937.3352069-1-thaller@redhat.com>
 <20231103162937.3352069-2-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103162937.3352069-2-thaller@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Nov 03, 2023 at 05:25:13PM +0100, Thomas Haller wrote:
[...]
> +	/* The json() hooks of "symbol_expr_ops" and "variable_expr_ops" are
> +	 * known to be NULL, but for such expressions we never expect to call
> +	 * expr_print_json().
> +	 *
> +	 * All other expr_ops must have a json() hook.
> +	 *
> +	 * Unconditionally access the hook (and segfault in case of a bug).  */
> +	return expr_ops(expr)->json(expr, octx);

This does not make sense to me. You're deliberately dropping any error
handling and accept a segfault because "it should never happen"? All it
takes is someone to add a new expression type and forget about the JSON
API.

If you absolutely have to remove that fallback code, at least add a
BUG() explaining the situation. The sysadmin looking at the segfault
report in syslog won't see your comment above.

Cheers, Phil
