Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86AB89C9B0
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Aug 2019 08:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfHZGzj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Aug 2019 02:55:39 -0400
Received: from mail.cadcon.de ([62.153.172.90]:49238 "EHLO mail.cadcon.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbfHZGzj (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Aug 2019 02:55:39 -0400
From:   "Priebe, Sebastian" <sebastian.priebe@de.sii.group>
To:     "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Feature request: Add support for linenoise as alternative to readline
Thread-Topic: Feature request: Add support for linenoise as alternative to
 readline
Thread-Index: AdVb2x49rFxIbIZYS9eLIbheBsrGLQ==
Date:   Mon, 26 Aug 2019 06:55:35 +0000
Message-ID: <4df20614cd10434b9f91080d0862dd0c@de.sii.group>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.240.16]
x-kse-serverinfo: SPMDEAGV001.CADCON.INTERN, 9
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 26.08.2019 01:24:00
x-kse-bulkmessagesfiltering-scan-result: protection disabled
x-pp-proceessed: 21f15ad8-196c-4557-8047-0cdd45d4777c
MIME-Version: 1.0
X-CompuMailGateway: Version: 6.00.4.19051.i686 COMPUMAIL Date: 20190826065536Z
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello dear netfilter folks,

I'd like to make an feature request:
Please add support for the linenoise library (https://github.com/antirez/linenoise) as an alternative to libreadline.
The linenoise library has a very small footprint and is often used in embedded environments.
This would enable the CLI on embedded devices.
Other projects that already have support for linenoise are e.g. SQLite.

Thank you very much for your attention.

Best regards
Sebastian Priebe



SII Technologies GmbH
Gesch?ftsf?hrer: Robert Bauer
Sitz der Gesellschaft: 86167 Augsburg
Registergericht: Amtsgericht Augsburg HRB 31802

