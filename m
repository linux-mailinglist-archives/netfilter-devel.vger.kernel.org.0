Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C77BC910E
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Oct 2019 20:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfJBSqZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Oct 2019 14:46:25 -0400
Received: from smtp-out.kfki.hu ([148.6.0.48]:52121 "EHLO smtp-out.kfki.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfJBSqY (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Oct 2019 14:46:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id 613EBCC0112;
        Wed,  2 Oct 2019 20:46:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        blackhole.kfki.hu; h=mime-version:user-agent:references
        :message-id:in-reply-to:from:from:date:date:received:received
        :received; s=20151130; t=1570041980; x=1571856381; bh=881R93mF3j
        NPssJtWDJ3Jh/Z/NqtdGCSqVIedC+0SVo=; b=reI4o1AQZm/EJ0S0PVna99o1qP
        yGT8fXIA7U4Unimx7HEXvgOhhuNrp7Bnqy9OnavHObJn6mBtQm/qoPIkjEiuBPLU
        /NKa59rTPU1S7KvkvdiocQmxDUrczNFc1+3h+n/k7tdwpuXnNUyCBYn9xMoeXt6d
        FKGQKwuRI5pE/75sc=
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Wed,  2 Oct 2019 20:46:20 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.kfki.hu [148.6.240.2])
        by smtp2.kfki.hu (Postfix) with ESMTP id 0611BCC0110;
        Wed,  2 Oct 2019 20:46:20 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id D4F3921ACF; Wed,  2 Oct 2019 20:46:19 +0200 (CEST)
Date:   Wed, 2 Oct 2019 20:46:19 +0200 (CEST)
From:   =?UTF-8?Q?Kadlecsik_J=C3=B3zsef?= <kadlec@blackhole.kfki.hu>
To:     Kristian Evensen <kristian.evensen@gmail.com>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] ipset: Add wildcard support to net,iface
In-Reply-To: <20190926105354.8301-1-kristian.evensen@gmail.com>
Message-ID: <alpine.DEB.2.20.1910022039530.21131@blackhole.kfki.hu>
References: <20190926105354.8301-1-kristian.evensen@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Kristian,

On Thu, 26 Sep 2019, Kristian Evensen wrote:

> The net,iface equal functions currently compares the full interface
> names. In several cases, wildcard (or prefix) matching is useful. For
> example, when converting a large iptables rule-set to make use of ipset,
> I was able to significantly reduce the number of set elements by making
> use of wildcard matching.
> 
> Wildcard matching is enabled by adding "wildcard" when adding an element
> to a set. Internally, this causes the IPSET_FLAG_IFACE_WILDCARD-flag to
> be set.  When this flag is set, only the initial part of the interface
> name is used for comparison.

Sorry for the long delay - I'm still pondering on the syntax.

ip[6]tables uses the "+" notation for prefix matching. So in order to be 
compatible with it, it'd be better to use "ifac+" instead of
"ifac prefix". The parsing/printing could be solved in the interface 
parser/printer functions internally. What do you think?

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.mta.hu
PGP key : http://www.kfki.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary
