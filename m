Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37108121FEA
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Dec 2019 01:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfLQAm7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Dec 2019 19:42:59 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:59598 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfLQAm7 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:42:59 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1ih0wz-0002IT-9P; Tue, 17 Dec 2019 01:42:57 +0100
Date:   Tue, 17 Dec 2019 01:42:57 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH nft,RFC] main: remove need to escape quotes
Message-ID: <20191217004257.GI14465@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, fw@strlen.de
References: <20191216214157.551511-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216214157.551511-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Mon, Dec 16, 2019 at 10:41:57PM +0100, Pablo Neira Ayuso wrote:
> If argv[i] contains spaces, then restore the quotes on this string.
> 
> There is one exception though: in case that argc == 2, then assume the
> whole input is coming as a quoted string, eg. nft "add rule x ...;add ..."
> 
> This patch is adjusting a one test that uses quotes to skip escaping one
> semicolon from bash. Two more tests do not need them.

I appreciate your efforts at making my BUGS note obsolete. :)
In this case though, I wonder if this really fixes something: I use
quotes in only two cases:

A) When forced by the parser, e.g. with interface names.
B) To escape the curly braces (and any semi-colons inside) in chain or
   set definitions.

Unless I miss something, case (A) will still need escaped quotes since
interface names usually don't contain whitespace. In case (B), your
patch would typically bite me as I merely quote the braces, like so:

| # nft add chain inet t c '{ type filter hook input priority filter; policy drop; }'

Of course that's a matter of muscle memory, but IIUC, your fix won't
work if one wants to pass flags in addition to a quoted command. Or does
getopt mangle argc?

Cheers, Phil
