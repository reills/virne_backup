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
  id 863
  arrival_time 18066.718768241826
  lifetime 1000.8496267902638
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 1
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 4
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 49
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 16
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 43
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 37
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 18
    gpu 30
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
]
