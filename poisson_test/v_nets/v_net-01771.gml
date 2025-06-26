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
  id 1771
  arrival_time 39453.80280464941
  lifetime 180.1962858806569
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 7
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 33
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 50
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 17
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 3
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 20
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 27
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 8
    gpu 1
    rom 37
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 16
    rom 7
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 48
    rom 25
  ]
  node [
    id 10
    label "10"
    cpu 29
    gpu 32
    rom 39
  ]
  node [
    id 11
    label "11"
    cpu 45
    gpu 45
    rom 45
  ]
  node [
    id 12
    label "12"
    cpu 13
    gpu 35
    rom 22
  ]
  node [
    id 13
    label "13"
    cpu 31
    gpu 24
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 46
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 28
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 6
  ]
  edge [
    source 9
    target 10
    bw 23
  ]
  edge [
    source 10
    target 11
    bw 20
  ]
  edge [
    source 11
    target 12
    bw 8
  ]
  edge [
    source 12
    target 13
    bw 16
  ]
]
