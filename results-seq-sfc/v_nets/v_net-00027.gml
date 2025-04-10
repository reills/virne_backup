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
  id 27
  arrival_time 575.26780121725
  lifetime 879.8028809426547
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 9
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 2
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 1
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 1
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 44
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 5
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 19
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 10
    gpu 9
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 12
    gpu 28
    rom 33
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 21
    rom 31
  ]
  node [
    id 10
    label "10"
    cpu 19
    gpu 46
    rom 31
  ]
  node [
    id 11
    label "11"
    cpu 48
    gpu 35
    rom 43
  ]
  node [
    id 12
    label "12"
    cpu 45
    gpu 29
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 38
  ]
  edge [
    source 7
    target 8
    bw 42
  ]
  edge [
    source 8
    target 9
    bw 10
  ]
  edge [
    source 9
    target 10
    bw 1
  ]
  edge [
    source 10
    target 11
    bw 41
  ]
  edge [
    source 11
    target 12
    bw 8
  ]
]
