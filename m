Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9233D296C04
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Oct 2020 11:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461391AbgJWJYS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 23 Oct 2020 05:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461335AbgJWJYS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:24:18 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33699C0613CE
        for <netfilter-devel@vger.kernel.org>; Fri, 23 Oct 2020 02:24:18 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id C79D95872C95F; Fri, 23 Oct 2020 11:24:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id C6A6060C26F0F;
        Fri, 23 Oct 2020 11:24:16 +0200 (CEST)
Date:   Fri, 23 Oct 2020 11:24:16 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH xtables-addons 3/3] pknock: pknlusr: add man-page.
In-Reply-To: <20201022173006.635720-4-jeremy@azazel.net>
Message-ID: <2p319p4q-576n-34r9-6oqn-7n93p6892rr@vanv.qr>
References: <20201022173006.635720-1-jeremy@azazel.net> <20201022173006.635720-4-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Thursday 2020-10-22 19:30, Jeremy Sowden wrote:

>Since pknlusr is now being installed, let's give it a man-page.

There's a lot of.. markup I have never seen before (and thus did not feel would
be necessary).
I pushed a shortened version; if anything should be different, please send more
patches on top. Thanks!
