Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C13FE120639
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Dec 2019 13:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfLPMrv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Dec 2019 07:47:51 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:49808 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727720AbfLPMrv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:47:51 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1igpmv-0004bK-JC; Mon, 16 Dec 2019 13:47:49 +0100
Date:   Mon, 16 Dec 2019 13:47:49 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH nft 0/3] typeof incremental enhancements
Message-ID: <20191216124749.GR795@breakpoint.cc>
References: <20191216124222.356618-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216124222.356618-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Hi Florian,
> 
> This patchset removes the need to self invoke the parser and the
> evaluation to fetch the datatype. Instead, the expression type and
> the expression description are stored into the userdata area.
> 
> This patch only supports for the payload expression, but it should be
> relatively easy to extend it to support for other existing expressions
> types.
> 
> This patch could be squashed into 06/11 src: add "typeof" print support
> of your patch series, which is actually not just adding support for
> printing but also for building the userdata.

I had considered that but found that storing netlink data
needs more space in the udata area compared to text and it needs more/extra
parsing for serialize/deserialize, so I abandoned this idea.

If you think its the way to go, then ok, I can rework it but
I will be unable to add the extra steps for other expression types
for some time I fear.
