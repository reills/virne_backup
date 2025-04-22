graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 889
  arrival_time 18819.407018138747
  lifetime 132.67743705180933
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 33
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 49
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 32
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 29
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 33
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 23
    rom 26
  ]
  node [
    id 6
    label "6"
    cpu 4
    gpu 24
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 10
    rom 15
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 11
    rom 3
  ]
  node [
    id 9
    label "9"
    cpu 37
    gpu 9
    rom 7
  ]
  node [
    id 10
    label "10"
    cpu 41
    gpu 40
    rom 36
  ]
  node [
    id 11
    label "11"
    cpu 28
    gpu 17
    rom 6
  ]
  node [
    id 12
    label "12"
    cpu 40
    gpu 7
    rom 31
  ]
  node [
    id 13
    label "13"
    cpu 32
    gpu 41
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 39
  ]
  edge [
    source 8
    target 9
    bw 36
  ]
  edge [
    source 9
    target 10
    bw 43
  ]
  edge [
    source 10
    target 11
    bw 22
  ]
  edge [
    source 11
    target 12
    bw 47
  ]
  edge [
    source 12
    target 13
    bw 0
  ]
]
