Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F44169A6F
	for <lists+netfilter-devel@lfdr.de>; Sun, 23 Feb 2020 23:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgBWWQL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 23 Feb 2020 17:16:11 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:45748 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgBWWQL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 23 Feb 2020 17:16:11 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1j5zXl-0004CG-A6; Sun, 23 Feb 2020 23:16:09 +0100
Date:   Sun, 23 Feb 2020 23:16:09 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 5/5] nft_set_pipapo: Introduce AVX2-based lookup
 implementation
Message-ID: <20200223221609.GY19559@breakpoint.cc>
References: <cover.1582488826.git.sbrivio@redhat.com>
 <02877a1cf5364db8f60a29a9a6aad705dea22dbd.1582488826.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02877a1cf5364db8f60a29a9a6aad705dea22dbd.1582488826.git.sbrivio@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Stefano Brivio <sbrivio@redhat.com> wrote:
> If the AVX2 set is available, we can exploit the repetitive
> characteristic of this algorithm to provide a fast, vectorised
> version by using 256-bit wide AVX2 operations for bucket loads and
> bitwise intersections.

Looks great, this needs a small rebase on top of nf-next now that
the dynamic set registration is gone.

