Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBE31CAE34
	for <lists+netfilter-devel@lfdr.de>; Fri,  8 May 2020 15:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgEHNHi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 8 May 2020 09:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729323AbgEHNHh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 8 May 2020 09:07:37 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB0EC05BD43
        for <netfilter-devel@vger.kernel.org>; Fri,  8 May 2020 06:07:37 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1jX2j0-0004Wd-UK; Fri, 08 May 2020 15:07:34 +0200
Date:   Fri, 8 May 2020 15:07:34 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: ETA of libnetfilter_queue-1.0.4?
Message-ID: <20200508130734.GE15009@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

I was requested to rebase libnetfilter_queue in RHEL. 1.0.3 allegedly
suffices, but it's 2.5 years old and there are quite a bunch of fixes in
git. Are you planning to do another release soon?

Cheers, Phil
