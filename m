Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9564F447F1A
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Nov 2021 12:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbhKHLsd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Nov 2021 06:48:33 -0500
Received: from mail.netfilter.org ([217.70.188.207]:47222 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhKHLsd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Nov 2021 06:48:33 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 60D396063C;
        Mon,  8 Nov 2021 12:43:50 +0100 (CET)
Date:   Mon, 8 Nov 2021 12:45:45 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Ken-ichirou MATSUZAWA <chamas@h4.dion.ne.jp>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnf-log] src: add conntrack ID to XML output
Message-ID: <YYkN6Xh2dfDLQDVA@salvia>
References: <YWTKdTsedRgM6Lgh@salvia>
 <20211012043912.18513-1-chamas@h4.dion.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211012043912.18513-1-chamas@h4.dion.ne.jp>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 12, 2021 at 01:39:14PM +0900, Ken-ichirou MATSUZAWA wrote:
> This patch enables to add conntrack ID as `ctid' element to XML output. Users
> could identify conntrack entries by this ID from another conntrack output.

Applied, thanks.

Please follow up to address comments from Jeremy regarding your ulogd2
patches.
