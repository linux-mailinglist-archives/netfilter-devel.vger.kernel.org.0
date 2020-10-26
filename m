Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47C3298A56
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Oct 2020 11:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769591AbgJZK0U (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Oct 2020 06:26:20 -0400
Received: from a3.inai.de ([88.198.85.195]:56350 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1768334AbgJZK0U (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Oct 2020 06:26:20 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 06:26:20 EDT
Received: by a3.inai.de (Postfix, from userid 25121)
        id C86515872642B; Mon, 26 Oct 2020 11:20:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id C34E560C26F0F;
        Mon, 26 Oct 2020 11:20:09 +0100 (CET)
Date:   Mon, 26 Oct 2020 11:20:09 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH xtables-addons] pnock: pknlusr: mention the group ID
 command-line paramater in the man-page.
In-Reply-To: <20201025181551.962197-1-jeremy@azazel.net>
Message-ID: <959466qq-rr2q-7334-3q5s-r3nsno359712@vanv.qr>
References: <20201025181551.962197-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sunday 2020-10-25 19:15, Jeremy Sowden wrote:

>-\fBpknlusr\fP
>+\fBpknlusr\fP [ \fIgroup-id\fP ]

processed
