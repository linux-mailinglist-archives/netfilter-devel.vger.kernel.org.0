Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EDA7D832C
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Oct 2023 14:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjJZMxR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 26 Oct 2023 08:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjJZMxQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:53:16 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7573AC
        for <netfilter-devel@vger.kernel.org>; Thu, 26 Oct 2023 05:53:14 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qvzrN-00069K-20; Thu, 26 Oct 2023 14:53:13 +0200
Date:   Thu, 26 Oct 2023 14:53:13 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 07/10] man: grammar fixes to some manpages
Message-ID: <ZTphOV/bYuotL2l0@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Jan Engelhardt <jengelh@inai.de>, netfilter-devel@vger.kernel.org
References: <20231026085506.94343-1-jengelh@inai.de>
 <20231026085506.94343-7-jengelh@inai.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026085506.94343-7-jengelh@inai.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:55:03AM +0200, Jan Engelhardt wrote:
> English generally uses open compounds rather than closed ones;
> fix the excess hyphens in words. Fix a missing dash for the
> portnr option as well.
> 
> Signed-off-by: Jan Engelhardt <jengelh@inai.de>
> ---
>  extensions/libxt_MASQUERADE.man |  2 +-
>  extensions/libxt_helper.man     | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/extensions/libxt_MASQUERADE.man b/extensions/libxt_MASQUERADE.man
> index e2009086..7cc2bb7a 100644
> --- a/extensions/libxt_MASQUERADE.man
> +++ b/extensions/libxt_MASQUERADE.man
> @@ -15,7 +15,7 @@ any established connections are lost anyway).
>  \fB\-\-to\-ports\fP \fIport\fP[\fB\-\fP\fIport\fP]
>  This specifies a range of source ports to use, overriding the default
>  .B SNAT
> -source port-selection heuristics (see above).  This is only valid
> +source port-selection heuristics (see above). This is only valid

Do you miss a dash in:

"default SNAT source port selection heuristics"? I lean towards putting
dashes everywhere, but my language spoils me. ;)

Thanks, Phil
