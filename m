Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B100DF9CD8
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Nov 2019 23:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKLWS3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 Nov 2019 17:18:29 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:48866 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfKLWS3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:18:29 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iUeUV-0002Ss-Rf; Tue, 12 Nov 2019 23:18:27 +0100
Date:   Tue, 12 Nov 2019 23:18:27 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] evaluate: Reject set references in mapping LHS
Message-ID: <20191112221827.GD11663@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191031182124.11393-1-phil@nwl.cc>
 <20191112214518.tsevqoqtm5ubov3p@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112214518.tsevqoqtm5ubov3p@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Nov 12, 2019 at 10:45:18PM +0100, Pablo Neira Ayuso wrote:
> On Thu, Oct 31, 2019 at 07:21:24PM +0100, Phil Sutter wrote:
> > This wasn't explicitly caught before causing a program abort:
> > 
> > | BUG: invalid range expression type set reference
> > | nft: expression.c:1162: range_expr_value_low: Assertion `0' failed.
> > | zsh: abort      sudo ./install/sbin/nft add rule t c meta mark set tcp dport map '{ @s : 23 }
> > 
> > With this patch in place, the error message is way more descriptive:
> > 
> > | Error: Key can't be set reference
> > | add rule t c meta mark set tcp dport map { @s : 23 }
> > |                                            ^^
> 
> I wanted to check why the parser allow for this...

For set elements or LHS parts of map elements, there is set_lhs_expr.
The latter may be concat_rhs_expr or multiton_rhs_expr. concat_rhs_expr
eventually resolves into primary_rhs_expr which may be symbol_expr.

BTW, it seems like from parser side, set references on map element's
RHS are allowed as well.

IMHO, parser_bison.y slowly but steadily turns into a can of worms. :(

Cheers, Phil
