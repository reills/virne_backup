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
  id 175
  arrival_time 3293.326328986701
  lifetime 322.0038682970206
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 3
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 16
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 50
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 17
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 19
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 22
    rom 14
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 43
    rom 34
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 30
    rom 46
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 31
    rom 9
  ]
  node [
    id 9
    label "9"
    cpu 27
    gpu 48
    rom 3
  ]
  node [
    id 10
    label "10"
    cpu 12
    gpu 1
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 8
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 7
  ]
]
