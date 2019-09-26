Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E13F3BEC9C
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Sep 2019 09:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbfIZHfm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 26 Sep 2019 03:35:42 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:46958 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbfIZHfm (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 26 Sep 2019 03:35:42 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iDOJN-0002CP-VA; Thu, 26 Sep 2019 09:35:37 +0200
Date:   Thu, 26 Sep 2019 09:35:37 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Sebastian Priebe <sebastian.priebe@de.sii.group>
Subject: Re: [PATCH nftables v2 0/2] Add Linenoise support to the CLI.
Message-ID: <20190926073537.GF22129@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Jeremy Sowden <jeremy@azazel.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Sebastian Priebe <sebastian.priebe@de.sii.group>
References: <20190924074055.4146-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924074055.4146-1-jeremy@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Sep 24, 2019 at 08:40:53AM +0100, Jeremy Sowden wrote:
> Sebastian Priebe [0] requested Linenoise support for the CLI as an
> alternative to Readline, so I thought I'd have a go at providing it.
> Linenoise is a minimal, zero-config, BSD licensed, Readline replacement
> used in Redis, MongoDB, and Android [1].
> 
>  0 - https://lore.kernel.org/netfilter-devel/4df20614cd10434b9f91080d0862dd0c@de.sii.group/
>  1 - https://github.com/antirez/linenoise/
> 
> By default, the CLI continues to be build using Readline, but passing
> `--with-cli=linenoise` instead causes Linenoise to be used instead.
> 
> `nft -v` has been extended to display what CLI implementation was built
> and whether mini-gmp was used.

Series:

Acked-by: Phil Sutter <phil@nwl.cc>
