Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BC53539A9
	for <lists+netfilter-devel@lfdr.de>; Sun,  4 Apr 2021 22:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhDDUFf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 4 Apr 2021 16:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbhDDUF2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 4 Apr 2021 16:05:28 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B9BC061788
        for <netfilter-devel@vger.kernel.org>; Sun,  4 Apr 2021 13:05:23 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lT8zl-0006oe-F2; Sun, 04 Apr 2021 22:05:17 +0200
Date:   Sun, 4 Apr 2021 22:05:17 +0200
From:   Florian Westphal <fw@strlen.de>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Harald Welte <laforge@netfilter.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: Unused macro
Message-ID: <20210404200517.GN13699@breakpoint.cc>
References: <f209f7b0-af4c-e41c-b53e-27028b925978@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <f209f7b0-af4c-e41c-b53e-27028b925978@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Alejandro Colomar (man-pages) <alx.manpages@gmail.com> wrote:
> I was updating the includes on some manual pages, when I found that a
> macro used ARRAY_SIZE() without including a header that defines it.
> That surprised me, because it would more than likely result in a compile
> error, but of course, the macro wasn't being used:
> 
> .../linux$ grep -rn SCTP_CHUNKMAP_IS_ALL_SET
> include/uapi/linux/netfilter/xt_sctp.h:80:#define
> SCTP_CHUNKMAP_IS_ALL_SET(chunkmap) \
> .../linux$

This is an UAPI header, this macro is used by userspace software, e.g.
iptables.
