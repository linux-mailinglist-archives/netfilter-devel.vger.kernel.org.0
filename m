Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC7E200B6A
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jun 2020 16:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgFSO3a (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 19 Jun 2020 10:29:30 -0400
Received: from dehost.average.org ([88.198.2.197]:49426 "EHLO
        dehost.average.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgFSO3a (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:29:30 -0400
Received: from wscross.pb.local (unknown [IPv6:2001:1438:4010:2548:9a90:96ff:fea0:e2f])
        by dehost.average.org (Postfix) with ESMTPSA id F2CD8354AD64
        for <netfilter-devel@vger.kernel.org>; Fri, 19 Jun 2020 16:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=average.org; s=mail;
        t=1592576969; bh=kVfLv6NonpIs7tLxfBkDBjBOnT9KFxnleql0feDkZr8=;
        h=From:To:Subject:Date:From;
        b=CdnOGIqKr2fbY7FgnRdixfzF7LB1TrrglsgX5+Wc5xg2zvtU5hNfuzhEFjB2gT+Se
         hGovQk39MYJzUHIunkXKBHaV4tL9AQRZWxqUFz2F5Rkqnrpxs91gRMm00SevcXpG8h
         PbxOHgI1NqAv02a51flljyd++kz8yh8jHYH/Nt7o=
From:   Eugene Crosser <crosser@average.org>
To:     netfilter-devel@vger.kernel.org
Subject: Allow dynamic loading of extentions in ebtables (-m option)
Date:   Fri, 19 Jun 2020 16:29:11 +0200
Message-Id: <20200619142912.19390-1-crosser@average.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

`iptables` command allows to dynamically load an "extension" shared
object by specifying the `-m` option, and thus new extensions can be
added without recompiling the command. In contrast, `ebtables` does
not have `-m` option. It still dynamically loads its extensions, but
the list of extenstions is hardcoded.

Proposed patch adds the option `-m` to `ebtables` command that works
the same way as in `iptables`. Note that

1. Hardcoded list of "standard" extentions is _not_ removed by this
 patch. It is not strictly necessary after this patch, but removing
it would break backwards compatibility, mandating addition of
`-m ext-name` option to existing scripts.

2. Dynamic loading of _target_ extensions already works automatically,
no change is needed.

Please consider adding this.

Thank you,

Eugene

