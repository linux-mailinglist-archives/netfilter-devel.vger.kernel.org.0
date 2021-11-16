Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB63D4531CE
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Nov 2021 13:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbhKPMKg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 16 Nov 2021 07:10:36 -0500
Received: from mail.netfilter.org ([217.70.188.207]:37358 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbhKPMJ1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:09:27 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 60DD0607A1;
        Tue, 16 Nov 2021 13:04:24 +0100 (CET)
Date:   Tue, 16 Nov 2021 13:06:25 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [ulogd2 PATCH v4 00/15] Build Improvements
Message-ID: <YZOewaJ0kmJ0Zvpw@salvia>
References: <20211114155231.793594-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211114155231.793594-1-jeremy@azazel.net>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Nov 14, 2021 at 03:52:16PM +0000, Jeremy Sowden wrote:
> Some tidying and autotools updates and fixes.

Series applied, thanks.

BTW, enabling a few output plugins here, such as pcap and dbi, I don't
think this is related to your patches. Probably acinclude.m4 can be
replaced by direct AC_CHECK_LIB() from configure.ac these days?
