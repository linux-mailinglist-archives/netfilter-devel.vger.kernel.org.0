Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADABB25782B
	for <lists+netfilter-devel@lfdr.de>; Mon, 31 Aug 2020 13:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgHaLVa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 31 Aug 2020 07:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgHaLR6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:17:58 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0A7C061239
        for <netfilter-devel@vger.kernel.org>; Mon, 31 Aug 2020 04:09:35 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 3A1785872C74C; Mon, 31 Aug 2020 13:09:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 34FEB60FA6D37;
        Mon, 31 Aug 2020 13:09:29 +0200 (CEST)
Date:   Mon, 31 Aug 2020 13:09:29 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Helmut Grohne <helmut@subdivi.de>
Subject: Re: [PATCH xtables-addons] build: don't hard-code pkg-config.
In-Reply-To: <20200831103635.524666-1-jeremy@azazel.net>
Message-ID: <nycvar.YFH.7.77.849.2008311309240.11784@n3.vanv.qr>
References: <20200831103635.524666-1-jeremy@azazel.net>
User-Agent: Alpine 2.22 (LSU 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Monday 2020-08-31 12:36, Jeremy Sowden wrote:

>From: Helmut Grohne <helmut@subdivi.de>
>
>Use $PKG_CONFIG in configure.ac in order to allow it to be overridden.
>Fixes cross-compilation.

It is done.
