Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D1940AEF7
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Sep 2021 15:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhINNdx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Sep 2021 09:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbhINNdw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Sep 2021 09:33:52 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737A4C061574
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Sep 2021 06:32:35 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 0CEBB59E2FED5; Tue, 14 Sep 2021 15:32:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 0BDD560C4A9A9;
        Tue, 14 Sep 2021 15:32:34 +0200 (CEST)
Date:   Tue, 14 Sep 2021 15:32:34 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>, kaskada@email.cz
Subject: Re: [xtables-addons] xt_ipp2p: fix compatibility with pre-5.1
 kernels
In-Reply-To: <20210913194607.134775-1-jeremy@azazel.net>
Message-ID: <918oro7-rrs-21rr-48p6-p1nqr4sp41@vanv.qr>
References: <20210913194607.134775-1-jeremy@azazel.net>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Monday 2021-09-13 21:46, Jeremy Sowden wrote:

>`ip_transport_len` and `ipv6_transport_len` were introduced in 5.1.
>They are both single-statement static inline functions, so add fall-back
>implementations for compatibility with older kernels.

Added.
