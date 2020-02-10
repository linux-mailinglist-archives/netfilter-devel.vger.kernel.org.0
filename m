Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0829157355
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 Feb 2020 12:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJLS4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Feb 2020 06:18:56 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:58818 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgBJLSz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:18:55 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1j175a-0003AC-1k; Mon, 10 Feb 2020 12:18:54 +0100
Date:   Mon, 10 Feb 2020 12:18:54 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 2/2] scanner: Extend asteriskstring definition
Message-ID: <20200210111853.GG19873@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20200206113828.7306-1-phil@nwl.cc>
 <20200206113828.7306-2-phil@nwl.cc>
 <20200207173140.hhqav2g6ckxnibmy@salvia>
 <20200207175902.GB19873@orbyte.nwl.cc>
 <20200209222143.inqrt7dehomhe7no@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200209222143.inqrt7dehomhe7no@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Sun, Feb 09, 2020 at 11:21:43PM +0100, Pablo Neira Ayuso wrote:
[...]
> Yes, I don't expect mid-string matching in the future, but you never
> know, so better reserve this just in case :-)

DONE, please see v2 I just sent.

> > BTW: Given how confusing bison-generated error messages are, maybe I
> > should introduce "infixasteriskstring" in scanner.l to catch unescaped
> > infix asterisks and generate a readable error message from there?
> 
> bison syntax error reporting is not great, yes. If you think that
> makes it easier for error reporting as a short term way to address the
> issue, that's fine with me.

Tried, but didn't go well - proper error reporting is best put into
parser_bison, but there one can't complain about mid-string asterisk
"anywhere" but only in defined places. So in others the then known token
will make error messages even more confusing.

Cheers, Phil
