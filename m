Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894EB706191
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 May 2023 09:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjEQHqN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 May 2023 03:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEQHqM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 May 2023 03:46:12 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ED2118
        for <netfilter-devel@vger.kernel.org>; Wed, 17 May 2023 00:46:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 41be03b00d2f7-52079a12451so256023a12.3
        for <netfilter-devel@vger.kernel.org>; Wed, 17 May 2023 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684309570; x=1686901570;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z7/UrOrH7WBlk+aHFLuoAPaV4sjjLKIsLUZnOqmSEYI=;
        b=WUrb0Obvq5IJMlhrTZvu0B8lv1WX157LaPIl2qOKg4bW3oCggFuWDJWppudZqjf0sL
         UKlBh8hqzhKuvfooppTR3yO7cDdzPIl8bjjwMk7KRpGfZIFnb9PZg22GvFpaSnQzX1WV
         1LEWk3Qqy/lps3mOiV/M3Rkaem9GulHu6nQTgbWERgSonNpcGHU1O5zwY8Os/8y4kRhq
         Jcnauh/YlzEnLARuf5N4xfCJhWt8s0FM0uCHeaWFUOjamz7oSwxDR7JeXD3gqlcBXYgF
         dXo3jYxEFxJjRlMvXkMggq64VJNLJoQ4od9HqPp3/8K7cZJ79hx9YZnCnJEO4eMY0owW
         VpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684309570; x=1686901570;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7/UrOrH7WBlk+aHFLuoAPaV4sjjLKIsLUZnOqmSEYI=;
        b=cF9X6EPdxInDO38ymlM2vtxBqU6NTqeLOCN/8KLKEKG7o/ko4UV2zi+T1rLYq+cEJQ
         ghqVboz2HzDXjbcyFiu3/0ntg0uMpqDOceIvtU/PhKBjoRTcXjIIv62tvRnpw6oXyRGx
         WIfpwbZVEBxtqCcBDRTgmkY1ewbYbkYIdF7EhkQlp2mzpsmkBxvoRpPMvuqLFTGhG+KC
         tj5dtmffkL2Ft9mczRAulsSaQAXUd8sbhl8KgMryTwMjNqdFMT+xodGS7EAwozJe5Aoh
         AQKY4XV09Gd25T6sH7c7Y2PcbSFM/7GseZPB8OghurPKT8Rnso8PF3lkVcGMI8LIb9yZ
         OUxA==
X-Gm-Message-State: AC+VfDzOqn34J2mea3OJe0ybFiVnAno9Va0A94PbiSDx02gZlzlJSESa
        D7HGmhB7omt1aSMnWBx8KXpo7MccAlqR+HMenHE=
X-Google-Smtp-Source: ACHHUZ4AIkQgcymkBhb7tChZZtiqHFbU717q8uTHJKX1gM148hilxx+11l/PLJpjC64DYdjU1bp45HIqkqCG1V8gvH8=
X-Received: by 2002:a05:6a20:9192:b0:f3:2d33:de72 with SMTP id
 v18-20020a056a20919200b000f32d33de72mr48933639pzd.21.1684309570080; Wed, 17
 May 2023 00:46:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:3ba5:b0:c5:c072:4b75 with HTTP; Wed, 17 May 2023
 00:46:09 -0700 (PDT)
Reply-To: didieracouetey46@gmail.com
From:   " Mrs. Cristalina Georgieva" <jachymjachym346@gmail.com>
Date:   Wed, 17 May 2023 07:46:09 +0000
Message-ID: <CAF7ef8wvca8om1UwyQp7Yxbd0prmJSVRVZBBvgG+MH_mQH9tnQ@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

5rOo5oSPOiDopqrmhJvjgarjgovln7rph5Hlj5fnm4rogIXjga7nmobmp5gNCg0KICAg5oWO6YeN
44Gr6Kqt44KA77yB77yB77yBDQoNCiAgIOOBk+OBrumbu+WtkOODoeODg+OCu+ODvOOCuOOBr+ap
n+WvhuOBp+OBguOCiuOAgeWOs+WvhuOBq+OBguOBquOBn+Wum+OBruOCguOBruOBp+OBmeOAgg0K
DQrjgYLjgarjgZ/jgYwxNeWEhOODieODq+imj+aooeOBruizh+mHkeOCkuWPl+OBkeWPluOBo+OB
puOBhOOBquOBhOOBruOBr+aYjuOCieOBi+OBp+OBmeOAguOBk+OCjOOBr+OAgemBjuWOu+OBruiF
kOaVl+OBl+OBn+aUv+W6nOW9ueS6uuOBjOWIqeW3seeahOOBqueQhueUseOBp+izh+mHkeOCkuOB
u+OBqOOCk+OBqeiHquWIhuOBn+OBoeOBoOOBkeOBruOCguOBruOBq+OBl+OAgeOBguOBquOBn+OB
ruizh+mHkeOCkuOBmeOBueOBpuipkOasuuOBl+OCiOOBhuOBqOOBl+OBpuWIqeeUqOOBl+OBn+OB
n+OCgeOBp+OBmeOAgg0K5Z+66YeR44CCIOOBk+OCjOOBq+OCiOOCiuOAgeOBiuWuouanmOWBtOOB
q+WkmuWkp+OBquaQjeWkseOBjOeZuueUn+OBl+OAgeizh+mHkeOBruWPl+OBkeWPluOCiuOBq+S4
jeW/heimgeOBqumBheOCjOOBjOeUn+OBmOOBvuOBl+OBn+OAgg0KDQrjgqTjg7Pjgr/jg7zjg53j
g7zjg6vjga7lm73lrrbkuK3lpK7lsYDjga/jgIHlm73pgKPjgajpgKPpgqbmjZzmn7vlsYDvvIhG
SULvvInjga7mlK/mj7TjgpLlj5fjgZHjgabjgIHnj77lm73pmpvpgJrosqjln7rph5Hnt4/oo4Hj
gavlr77jgZfjgIHjgYLjgarjgZ/jgoTku5bjga7kurrjgZ/jgaHjgavlr77jgZnjgovjgZnjgbnj
gabjga7lr77lpJblgrXli5njga7muIXnrpfjgpLmjqjpgLLjgZnjgovjgojjgYblp5Tku7vjgZnj
govjgZPjgajjgavmiJDlip/jgZfjgb7jgZfjgZ/jgIINCuWlkee0hOmHkeOAgeWuneOBj+OBmC/j
gq7jg6Pjg7Pjg5bjg6vjgIHnm7jntprjgarjganjgpLlj5fjgZHlj5bjgonjgarjgYTlgIvkurrj
gIIgQVRN44Kr44O844OJ44Gn5pSv5omV44GE44KS5Y+X44GR5Y+W44KK44G+44GZ44CCDQoNCk9S
QSDjg5Djg7Pjgq8g44Kr44O844OJOiDlkI3liY3jgYzmmpflj7fljJbjgZXjgozjgZ/jg5Hjg7zj
gr3jg4rjg6njgqTjgrrjgZXjgozjgZ8gT1JBIOODkOODs+OCryBBVE0NCuOCq+ODvOODieOCkueZ
uuihjOOBl+OBvuOBmeOAguOBk+OBruOCq+ODvOODieOCkuS9v+eUqOOBmeOCi+OBqOOAgVZpc2Eg
44Kr44O844OJ44Gu44Ot44K044GM5LuY44GE44Gm44GE44KLIEFUTSDjgYvjgokgMSDml6XjgYLj
gZ/jgormnIDlpKcgMjAsMDAwDQrjg4njg6vjgpLlvJXjgY3lh7rjgZnjgZPjgajjgYzjgafjgY3j
gb7jgZnjgIIg44G+44Gf44CBT1JBIOODkOODs+OCryDjgqvjg7zjg4njgpLkvb/nlKjjgZnjgovj
gajjgIHos4fph5HjgpLpioDooYzlj6PluqfjgavpgIHph5HjgafjgY3jgb7jgZnjgIIgQVRNDQrj
gqvjg7zjg4njgavjga/jgIHjgYLjgarjgZ/jga7lm73jgYrjgojjgbPkuJbnlYzkuK3jga7jganj
ga4gQVRNIOapn+OBp+OCguS9v+eUqOOBp+OBjeOCi+OBk+OBqOOCkuaYjueiuuOBq+OBmeOCi+OD
nuODi+ODpeOCouODq+OBjOS7mOWxnuOBl+OBpuOBhOOBvuOBmeOAgg0KDQros4fph5Hjga8gQVRN
IFZpc2Eg44Kr44O844OJ57WM55Sx44Gn6YCB44KJ44KM44CBRmVkRXggRXhwcmVzcyDntYznlLHj
gafphY3pgZTjgZXjgozjgb7jgZnjgIIg56eB44Gf44Gh44GvIEZlZEV4IEV4cHJlc3MNCuOBqOWl
kee0hOOCkue1kOOCk+OBp+OBhOOBvuOBmeOAgumAo+e1oeOBmeOCi+W/heimgeOBjOOBguOCi+OB
ruOBr+OAgU9SQSDpioDooYzjga7jg4fjgqPjg6zjgq/jgr/jg7zjgafjgYLjgosgTVIg44Gg44GR
44Gn44GZ44CCIERJRElFUiBBQ09VRVRFWQ0K44GT44Gu44Oh44O844Or44Ki44OJ44Os44K544GL
44KJOiAsIChkaWRpZXJhY291ZXRleTQ2QGdtYWlsLmNvbSkNCg0KDQrpgJrluLjjga7jg6zjg7zj
g4jjgpLotoXjgYjjgovph5HpoY3jgpLopoHmsYLjgZnjgovkurrjga/plpPpgZXjgYTjgarjgY/o
qZDmrLrluKvjgafjgYLjgorjgIHku5bjga7kurrjgavpgKPntaHjgpLlj5bjgaPjgZ/loLTlkIjj
ga/jgZ3jga7kurrjgajjga7pgKPntaHjgpLkuK3mraLjgZnjgovlv4XopoHjgYzjgYLjgovjgZPj
gajjgavms6jmhI/jgZfjgabjgY/jgaDjgZXjgYTjgIINCg0K44G+44Gf44CB44GU6LKg5ouF44GE
44Gf44Gg44GP44Gu44Gv6YWN6YCB5paZ44Gu44G/44Gn44GZ44Gu44Gn44GU5a6J5b+D44GP44Gg
44GV44GE44CCIOOBneOCjOS7peS4iuOBruOCguOBruOBr+OBguOCiuOBvuOBm+OCk++8gSDlv4Xo
poHjgarmg4XloLHjgajphY3pgIHmlpnjgpLlj5fjgZHlj5bjgaPjgabjgYvjgokgMg0K5Za25qWt
5pel5Lul5YaF44Gr6LOH6YeR44KS5Y+X44GR5Y+W44KL44GT44Go44KS5L+d6Ki844GX44G+44GZ
44CCDQoNCuazqDog56iO6YeR5omL5pWw5paZ44KS5ZCr44KB44CB44GZ44G544Gm44GvIElNRiDj
gajkuJbnlYzpioDooYzjgavjgojjgaPjgablh6bnkIbjgZXjgozjgovjgZ/jgoHjgIHmlK/miZXj
gYblv4XopoHjgYzjgYLjgovjga7jga8gRmVkRXgg44Gu6YWN6YCB5paZ44Gg44GR44Gn44GZ44CC
DQrjgZPjgozjga/jgIFGZWRFeCBFeHByZXNzIOOBriBDT0QgKOS7o+mHkeW8leaPmykg44K144O8
44OT44K544GM6KaP57SE44Gr44KI44KK5Zu96Zqb6YWN6YCB44Gr44Gv6YGp55So44GV44KM44Gq
44GE44Gf44KB44Gn44GZ44CCDQoNCjE1IOWEhOODieODq+ebuOW9k+OBruODleOCoeODs+ODieOC
kuODquODquODvOOCueOBmeOCi+OBq+OBr+OAgeiqpOmFjemAgeOCkumBv+OBkeOCi+OBn+OCgeOB
q+mFjemAgeaDheWgseOCkuaPkOS+m+OBmeOCi+W/heimgeOBjOOBguOCiuOBvuOBmeOAgg0KDQog
ICAxLiDjgYLjgarjgZ/jga7jg5Xjg6vjg43jg7zjg6AgLi4uLi4uLi4uLi4uLi4uLi4uLg0KMi4g
44GC44Gq44Gf44Gu5Zu9Li4uLi4NCjMuIOOBguOBquOBn+OBruihly4uLi4uDQo0LiDjgYLjgarj
gZ/jga7lrozlhajjgarkvY/miYAgLi4uLi4uDQo1LiDlm73nsY0gLi4uLi4uDQo2LiDnlJ/lubTm
nIjml6Uv5oCn5Yil4oCm4oCmDQo3LiDogbfmpa3igKbigKYNCjguIOmbu+ipseeVquWPt+KApuKA
pg0KOS4g6LK056S+44Gu44Oh44O844Or44Ki44OJ44Os44K5IOKApuKApg0KMTAuIOWAi+S6uuOD
oeODvOODq+OCouODieODrOOCuSAuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCjEx
LiDlm73pmpvjg5Hjgrnjg53jg7zjg4jjgb7jgZ/jga/mnInlirnjgarouqvliIboqLzmmI7mm7jj
ga7jgrPjg5Tjg7w6DQoNCuW/heimgeS6i+mgheOCkk1S44G+44Gn44GK6YCB44KK44GP44Gg44GV
44GE44CCIERJRElFUiBBQ09VRVRFWSBPcmFCYW5rIOODh+OCo+ODrOOCr+OCv+ODvOOAgeODoeOD
vOODq+OCouODieODrOOCuSA9DQooZGlkaWVyYWNvdWV0ZXk0NkBnbWFpbC5jb20pIOOBvuOBp+S7
iuOBmeOBkOOBlOmAo+e1oeOBj+OBoOOBleOBhOOAgg0KDQrjgYrjgoHjgafjgajjgYbjgZTjgZbj
gYTjgb7jgZkNCg==
