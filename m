Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E264B2304DE
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Jul 2020 10:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgG1IDG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Jul 2020 04:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgG1IDG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:03:06 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF3C061794
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jul 2020 01:03:05 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 23AD858726429; Tue, 28 Jul 2020 10:03:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 22C9160C531ED;
        Tue, 28 Jul 2020 10:03:04 +0200 (CEST)
Date:   Tue, 28 Jul 2020 10:03:04 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH xtables-addons v2] doc: fix quoted string in libxt_DNETMAP
 man-page.
In-Reply-To: <20200721130345.717735-1-jeremy@azazel.net>
Message-ID: <nycvar.YFH.7.77.849.2007281002570.16610@n3.vanv.qr>
References: <20200721130345.717735-1-jeremy@azazel.net>
User-Agent: Alpine 2.22 (LSU 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tuesday 2020-07-21 15:03, Jeremy Sowden wrote:

>In roff, lines beginning with a single quote are control lines.[..]

Added.
