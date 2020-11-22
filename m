Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9F12BC754
	for <lists+netfilter-devel@lfdr.de>; Sun, 22 Nov 2020 17:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgKVQzF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 22 Nov 2020 11:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgKVQzF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 22 Nov 2020 11:55:05 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD407C0613CF
        for <netfilter-devel@vger.kernel.org>; Sun, 22 Nov 2020 08:55:04 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 53BC25875029A; Sun, 22 Nov 2020 17:55:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 4DB8A60D39B05;
        Sun, 22 Nov 2020 17:55:03 +0100 (CET)
Date:   Sun, 22 Nov 2020 17:55:03 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH xtables-addons 0/4] geoip: script fixes
In-Reply-To: <20201122140530.250248-1-jeremy@azazel.net>
Message-ID: <702191n9-1n33-9027-n968-nqs36r0q288@vanv.qr>
References: <20201122140530.250248-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sunday 2020-11-22 15:05, Jeremy Sowden wrote:

>A couple of fixes and some man-pages for the MaxMind geoip scripts.
>
>Jeremy Sowden (4):
>  geoip: remove superfluous xt_geoip_fetch_maxmind script.
>  geoip: fix man-page typo'.
>  geoip: add man-pages for MaxMind scripts.
>  geoip: use correct download URL for MaxMind DB's.

Applied.
