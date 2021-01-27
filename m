Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA28F30674B
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Jan 2021 23:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhA0Wzi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Jan 2021 17:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhA0WzK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:55:10 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7194C061352
        for <netfilter-devel@vger.kernel.org>; Wed, 27 Jan 2021 14:51:37 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1l4tew-0000TL-Nv; Wed, 27 Jan 2021 23:51:34 +0100
Date:   Wed, 27 Jan 2021 23:51:34 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <snemec@redhat.com>
Cc:     netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        =?utf-8?B?VG9tw6HFoSBEb2xlxb5hbA==?= <todoleza@redhat.com>
Subject: Re: [PATCH] tests: monitor: use correct $nft value in EXIT trap
Message-ID: <20210127225134.GU3158@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <snemec@redhat.com>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        =?utf-8?B?VG9tw6HFoSBEb2xlxb5hbA==?= <todoleza@redhat.com>
References: <20210127140203.2099010-1-snemec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210127140203.2099010-1-snemec@redhat.com>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jan 27, 2021 at 03:02:03PM +0100, Štěpán Němec wrote:
> With double quotes, $nft was being expanded to the default value even
> in presence of the -H option.
> 
> Signed-off-by: Štěpán Němec <snemec@redhat.com>
> Helped-by: Tomáš Doležal <todoleza@redhat.com>
> Acked-by: Phil Sutter <phil@nwl.cc>

Applied, thanks!
