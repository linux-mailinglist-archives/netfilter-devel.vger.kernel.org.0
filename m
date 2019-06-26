Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32165734C
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Jun 2019 23:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfFZVGJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Jun 2019 17:06:09 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:43486 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbfFZVGJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:06:09 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hgF7I-00068T-8K; Wed, 26 Jun 2019 23:06:08 +0200
Date:   Wed, 26 Jun 2019 23:06:08 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ander Juaristi <a@juaristi.eus>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] nftables: tests/py: Add tests for day and hour
Message-ID: <20190626210608.323u3qyrzmcnarir@breakpoint.cc>
References: <20190626204402.5257-1-a@juaristi.eus>
 <20190626204402.5257-4-a@juaristi.eus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626204402.5257-4-a@juaristi.eus>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ander Juaristi <a@juaristi.eus> wrote:
> index 322c087..ad00a1a 100644
> --- a/tests/py/ip/meta.t.payload
> +++ b/tests/py/ip/meta.t.payload
> @@ -1,3 +1,15 @@
> +# meta day "Saturday" drop
> +ip test-ip4 input
> +  [ meta load unknown => reg 1 ]

This 'unknown' is coming from libnftnl.
You will need to make a small patch that adds the new
keys to the string table, similar to

commit 179a43db739b8151d608452d01b66f65ac8aa5e5
meta: secpath support

in libnftnl.
