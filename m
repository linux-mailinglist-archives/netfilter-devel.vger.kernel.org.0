Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D532296BDC
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Oct 2020 11:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461202AbgJWJNt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 23 Oct 2020 05:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461196AbgJWJNt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:13:49 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04A3C0613CE
        for <netfilter-devel@vger.kernel.org>; Fri, 23 Oct 2020 02:13:48 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 959C15872C95F; Fri, 23 Oct 2020 11:13:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 90B9360C26F0F;
        Fri, 23 Oct 2020 11:13:45 +0200 (CEST)
Date:   Fri, 23 Oct 2020 11:13:45 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH xtables-addons 2/3] pknock: pknlusr: fix hard-coded
 netlink multicast group ID.
In-Reply-To: <20201022173006.635720-3-jeremy@azazel.net>
Message-ID: <3ns38p0-1pp5-3185-5r96-rqqo2r77s8p2@vanv.qr>
References: <20201022173006.635720-1-jeremy@azazel.net> <20201022173006.635720-3-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thursday 2020-10-22 19:30, Jeremy Sowden wrote:

>The group ID used by xt_pknock is configurable, but pknlusr hard-codes
>it to 1.  Modify pknlusr to accept an optional ID from the command-line.

According to netlink(7), that is not a group ID but a bitmask of groups.
That changes the semantic quite significantly and would make this patch faulty.

>+		n = strtol(argv[1], &end, 10);
>+		if (*end || n < INT_MIN || n > INT_MAX) {
>+			usage(argv[0]);
>+			exit(EXIT_FAILURE);
>+		}

It's a u32. It can never be less than 0, but it can very well be more than
INT_MAX.
