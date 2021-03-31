Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D716A3508B0
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Mar 2021 23:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhCaVBP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 Mar 2021 17:01:15 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49068 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhCaVAr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:00:47 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 97B5063E47
        for <netfilter-devel@vger.kernel.org>; Wed, 31 Mar 2021 23:00:31 +0200 (CEST)
Date:   Wed, 31 Mar 2021 23:00:44 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: nf-next rebase...
Message-ID: <20210331210044.GA5136@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

I have just squashed an incremental UAF fix for the recent audit patch
as well as the small fix for the logging rework from Florian.

Please, rebase your nf-next local tree.

Sorry for the inconvenience.
