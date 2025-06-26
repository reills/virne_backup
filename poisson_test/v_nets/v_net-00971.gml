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
  id 971
  arrival_time 20553.45924444739
  lifetime 952.1442668114742
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 13
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 33
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 43
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 20
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 42
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 14
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 32
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 34
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 29
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 27
  ]
]
